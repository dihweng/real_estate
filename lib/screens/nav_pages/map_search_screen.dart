import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:real_estate/utils/helper_widgets.dart';
import '../../locator.dart';
import '../../services/error_state.dart';
import '../../utils/colors.dart';
import '../../utils/local_store.dart';
import '../../widgets/animated_center_expansion.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/size_transition_container.dart';

class MapSearch extends StatefulWidget {
  const MapSearch({super.key});

  @override
  State<MapSearch> createState() => _MapSearchState();
}

class _MapSearchState extends State<MapSearch> with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final ErrorState _errorStateCtrl = locator<ErrorState>();

  // Map-related variables
  LatLng _initialPosition = LatLng(59.9311, 30.3609); // St. Petersburg Coordinates
  Position? _currentPosition;
  bool _isCardVisible = false; // Controls the visibility of the sliding card
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  // List of bookmarked locations
  List<LatLng> _bookmarkedLocations = [
    LatLng(59.9311, 30.3609), // St. Petersburg
    LatLng(40.7128, -74.0060), // New York City
    LatLng(48.8566, 2.3522),   // Paris
    LatLng(34.0522, -118.2437) // Los Angeles
  ];

  // List of markers (for bookmarks)
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _checkPermissionAndGetLocation();
    _generateMarkers(); // Generate markers for the bookmarked locations

    // Initialize the animation controller and slide animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1),  // Start off-screen (below FAB)
      end: Offset(0, 0),    // Slide into place (aligned with FAB)
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  // Function to generate markers from the bookmarked locations
  void _generateMarkers() {
    _markers = _bookmarkedLocations.map((location) {
      return Marker(
        width: 80.0,
        height: 80.0,
        point: location,
        child: IconButton(
          icon: Icon(Icons.bookmark, color: Colors.red),
          onPressed: () {
            // Optionally center the map on this location
            _centerMapOnBookmark(location);
          },
        ),
      );
    }).toList();
  }

  // Function to center map on a bookmark
  Future<void> _centerMapOnBookmark(LatLng bookmark) async {
    final mapController = MapController(); // Use a controller to interact with the map
    mapController.move(bookmark, 14.0);    // Move to bookmark with a zoom level of 14
  }

  // Function to check location permissions and request if not granted
  Future<void> _checkPermissionAndGetLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Location services are disabled. Please enable them in settings.'),
      ));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Location permission is denied. Please allow access to use this feature.'),
        ));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Location permissions are permanently denied. Please enable them from settings.'),
      ));
      return;
    }

    await _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
        _initialPosition = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  // Method to build the filter card
  Widget _buildFilterCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title of the card
            Text(
              'Select Filter',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // List of items (like the one in the image)
            _buildFilterItem('Cosy areas', Icons.home),
            _buildFilterItem('Price', Icons.attach_money),
            _buildFilterItem('Infrastructure', Icons.location_city),
            _buildFilterItem('Without any layer', Icons.layers_clear),
          ],
        ),
      ),
    );
  }

  // Helper method to build filter items
  Widget _buildFilterItem(String label, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.orange),
      title: Text(label),
      onTap: () {
        setState(() {
          _isCardVisible = false; // Hide the card after selection
          _animationController.reverse(); // Slide the card back down
        });
        // Perform any action on selection
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Stack(
          children: [
            // Map with bookmark markers
            FlutterMap(
              options: MapOptions(
                  initialCenter: _initialPosition,
                  initialZoom: 12.0,
                  crs: const Epsg3857() // Common CRS for OpenStreetMap tiles
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: _markers, // Add the list of bookmark markers here
                ),
              ],
            ),

            // Search bar at the top
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  // Search input
                  Expanded(
                    child: AnimatedContainerExpand(
                      maxWidth: MediaQuery.of(context).size.width * 0.72,
                      maxHeight: 58,
                      child: Container(
                        height: 46,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: AppTextField(
                          textInputType: TextInputType.streetAddress,
                          labelText: "",
                          textController: searchController,
                          autoFocus: false,
                          isPassword: false,
                          hintText: 'Search',
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ),
                  ),
                  addHorizontalSpace(10),
                  // Filter button
                  SizeTransitionContainer(
                    maxSize: 58,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child:  Icon(Icons.link, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),

            // Sliding card with filter options
            AnimatedSlide(
              offset: _slideAnimation.value,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Visibility(
                visible: _isCardVisible,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildFilterCard(),
                ),
              ),
            ),

            // Three action buttons at the bottom, above BottomNavigationBar
            Positioned(
              bottom: 100,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _isCardVisible = !_isCardVisible;

                            if (_isCardVisible) {
                              _animationController.forward(); // Show the card
                            } else {
                              _animationController.reverse(); // Hide the card
                            }
                          });
                        },
                        backgroundColor: Colors.black.withOpacity(0.2), // Set background color to transparent
                        elevation: 0, // Remove elevation shadow
                        child: Icon(Icons.list, color: Colors.black),
                      ),
                      addVerticalSpace(4),
                      FloatingActionButton(
                        onPressed: () {
                          // Handle action for button 2
                        },
                        backgroundColor: Colors.black.withOpacity(0.2), // Set background color to transparent
                        elevation: 0, // Remove elevation shadow
                        child: Icon(Icons.location_pin, color: Colors.red),
                      ),
                    ],
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      // Handle action for button 3
                    },
                    backgroundColor: Colors.black.withOpacity(0.2), // Set background color to transparent
                    elevation: 0, // Remove elevation shadow
                    child: Icon(Icons.directions, color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
