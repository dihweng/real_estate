import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:real_estate/utils/helper_widgets.dart';
import 'package:real_estate/widgets/app_text.dart';
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

  LatLng _initialPosition = LatLng(59.9311, 30.3609); // St. Petersburg Coordinates
  Position? _currentPosition;
  bool _isCardVisible = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  // Added a MapController to allow map interaction
  final MapController _mapController = MapController();

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
    _generateMarkers();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Off-screen
      end: Offset(-40, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  void _generateMarkers() {
    _markers = _bookmarkedLocations.map((location) {
      return Marker(
        width: 80.0,
        height: 80.0,
        point: location,
        child: IconButton(
          icon: Icon(Icons.bookmark, color: Colors.red),
          onPressed: () {
            _centerMapOnBookmark(location);
          },
        ),
      );
    }).toList();
  }

  Future<void> _centerMapOnBookmark(LatLng bookmark) async {
    _mapController.move(bookmark, 14.0); // Move to bookmark location
  }

  Future<void> _checkPermissionAndGetLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Location services are disabled.'),
      ));
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Location permission denied.'),
        ));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Location permissions are permanently denied.'),
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
        _mapController.move(_initialPosition, 14.0); // Center map on current location
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Widget _buildFilterCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(16),
        width: 200,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterItem('Cosy areas', Icons.home),
            _buildFilterItem('Price', Icons.attach_money),
            _buildFilterItem('Infrastructure', Icons.location_city),
            _buildFilterItem('Without any layer', Icons.layers_clear),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterItem(String label, IconData icon) {
    return InkWell(
      onTap: () {
        setState(() {
          _isCardVisible = false;
          _animationController.reverse();
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.orange),
            addHorizontalSpace(8),
            AppText(text: label, size: 14),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Stack(
          children: [
            // Flutter map with controller and markers
            FlutterMap(
              mapController: _mapController, // Added MapController
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
                  markers: _markers,
                ),
              ],
            ),

            // Search bar and filter button
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  Expanded(
                    child: AnimatedContainerExpand(
                      maxWidth: MediaQuery.of(context).size.width * 0.72,
                      maxHeight: 50,
                      child: Container(
                        height: 30,
                        clipBehavior: Clip.hardEdge,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
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
                  SizeTransitionContainer(
                    maxSize: 58,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(Icons.link, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),

            // Sliding filter card
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

            // Floating action buttons
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
                            _isCardVisible
                                ? _animationController.forward()
                                : _animationController.reverse();
                          });
                        },
                        backgroundColor: Colors.black.withOpacity(0.2),
                        elevation: 0,
                        child: Icon(Icons.list, color: Colors.black),
                      ),
                      addVerticalSpace(4),
                      FloatingActionButton(
                        onPressed: () {
                          _getCurrentLocation(); // Center on current location
                        },
                        backgroundColor: Colors.black.withOpacity(0.2),
                        elevation: 0,
                        child: Icon(Icons.location_pin, color: Colors.red),
                      ),
                    ],
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        _mapController.move(_initialPosition, 10);
                      });
                    },
                    child: Icon(Icons.gps_fixed, color: Colors.orange),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
