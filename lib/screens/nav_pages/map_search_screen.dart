import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:real_estate/utils/helper_widgets.dart';
import '../../locator.dart';
import '../../services/error_state.dart';
import '../../utils/colors.dart';
import '../../utils/local_store.dart';
import '../../widgets/app_text_field.dart';

class MapSearch extends StatefulWidget {
  const MapSearch({super.key});

  @override
  State<MapSearch> createState() => _MapSearchState();
}

class _MapSearchState extends State<MapSearch> with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  String name = 'Please enter your name here';
  String? email = '';
  String? phoneNumber = '';
  final _formkey = GlobalKey<FormState>();
  final ErrorState _errorStateCtrl = locator<ErrorState>();

  // Google Maps related variables
  Completer<GoogleMapController> _controller = Completer();
  Position? _currentPosition;
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(59.9311, 30.3609), // St. Petersburg Coordinates
    zoom: 12,
  );

  // Listen to the error stream
  late StreamSubscription<ErrorStatus> errorStateSub;
  late Stream<Map<String, dynamic>> userDetails = const Stream.empty();

  @override
  void initState() {
    super.initState();
    _checkPermissionAndGetLocation();
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
      });

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14,
        ),
      ));
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,

        body: Stack(
          children: [
            // Google Maps widget
            GoogleMap(
              initialCameraPosition: _initialCameraPosition,
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
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
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: AppTextField(
                          textInputType: TextInputType.emailAddress,
                          labelText: "",
                          textController: searchController,
                          autoFocus: false,
                          // onFocus: userEmailFocusNode,
                          isPassword: false,
                          hintText: 'Email',
                          onEditingComplete: () {
                          },
                          textInputAction: TextInputAction.done),
                    ),
                  ),
                  SizedBox(width: 10),
                  // Filter button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Handle filter button click
                      },
                      icon: Icon(Icons.filter_alt_outlined, color: Colors.grey),
                    ),
                  ),
                ],
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
                          // Handle action for button 1
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
            // Floating Bottom Navigation Bar
            // Positioned(
            //   bottom: 20,
            //   left: 0,
            //   right: 0,
            //   child: BottomNavigationBar(
            //     items: const <BottomNavigationBarItem>[
            //       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            //       BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
            //       BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            //     ],
            //     currentIndex: 0, // Update this index based on the selected tab
            //     onTap: (index) {
            //       // Handle tab changes here
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
