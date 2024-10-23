import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_estate/screens/home_page/home_page.dart';
import 'package:real_estate/screens/nav_pages/map_search_screen.dart';
import 'package:real_estate/screens/nav_pages/message_screen.dart';
import 'package:real_estate/screens/nav_pages/settings_screen.dart';
import '../../utils/colors.dart';
import 'favourites.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {
  List<Widget> pages = [
    const MapSearch(),
    const MessageScreen(),
    const HomePage(title: 'Real Estate'),
    const Favourites(),
    const SettingsScreen(),
  ];

  int currentIndex = 2;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a fast duration for the slide-in
    _animationController = AnimationController(
      vsync: this,
      // Fast animation
      duration: const Duration(milliseconds: 300),
    );

    // Set the slide animation from Offset(0, 1) (off the screen at bottom) to Offset(0, 0) (fully visible)
    _slideAnimation = Tween<Offset>(
      // Start below the screen
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    // Start the animation with a delay
    Future.delayed(const Duration(milliseconds: 2500), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIndex == 2) {
          // Close the app if on the home screen
          SystemNavigator.pop();
          return false;
        } else {
          setState(() {
            currentIndex = (currentIndex - 1).clamp(0, pages.length - 1);
          });
          return false;
        }
      },
      child: SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          body: Stack(
            children: [
              // MapSearch is used as the background layer, can be any map or content widget
              pages[currentIndex],

              // Floating CustomBottomNavigationBar
              Positioned(
                bottom: 0,
                left: 20,
                right: 20,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: CustomBottomNavigationBar(
                    currentIndex: currentIndex,
                    onTap: onTap,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: AppColors.bodyTextColorLightTheme.withOpacity(0.9),
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(Icons.search, 0),
          _buildNavItem(Icons.message, 1),
          _buildNavItem(Icons.home_filled, 2),
          _buildNavItem(Icons.favorite, 3),
          _buildNavItem(Icons.person, 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    bool isMain = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: EdgeInsets.all(isMain ? 15.0 : 10.0),
        decoration: isMain
            ? BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        )
            : null,
        child: Icon(
          icon,
          size: isMain ? 30.0 : 24.0,
          color: isMain
              ? AppColors.logoBackgroundColor
              : AppColors.logoBackgroundColor.withOpacity(0.6),
        ),
      ),
    );
  }
}