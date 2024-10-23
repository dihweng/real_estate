import 'package:flutter/material.dart';
import 'package:real_estate/utils/colors.dart';
import 'package:real_estate/utils/helper_widgets.dart';
import 'package:real_estate/widgets/animated_slide_text.dart';
import 'package:real_estate/widgets/animated_text.dart';
import '../../widgets/animated_center_expansion.dart';
import '../../widgets/animated_container_no_opacity.dart';
import '../../widgets/app_text.dart';
import '../../widgets/back_custom_app_bar.dart';
import 'dart:math';

import '../../widgets/size_transition_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  String screenTitle = 'Ekeja'; // Default screen title
  Random random = Random(); // Random generator for dynamic heights

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  List<Map<String, dynamic>> gridData = [
    {'imagePath': 'assets/images/1.png', 'label': 'Mirchi 90\'s Radio - F'},
    {'imagePath': 'assets/images/monday.png', 'label': 'Punjabi Mirchi'},
    {'imagePath': 'assets/images/3.png', 'label': 'Meethi Mirchi Radio - M'},
    {'imagePath': 'assets/images/5.png', 'label': 'Mirchi Campus'},
    {'imagePath': 'assets/images/6.png', 'label': 'Club Mirchi Radio - P'},
    {'imagePath': 'assets/images/7.png', 'label': 'Mirchi Indies Radio'},
    {'imagePath': 'assets/images/8.png', 'label': 'Mirchi Top 20 Radio'},
    {'imagePath': 'assets/images/9.png', 'label': 'Podcast'},
    {'imagePath': 'assets/images/10.png', 'label': 'Mirchi Love'},
    {'imagePath': 'assets/images/11.png', 'label': 'Filmy Mirchi Radio - '},
    {'imagePath': 'assets/images/12.png', 'label': 'Volume Campus'},
    {'imagePath': 'assets/images/1.png', 'label': 'Home Party'},
    {'imagePath': 'assets/images/2.png', 'label': 'Podcast Love'},
    {'imagePath': 'assets/images/3.png', 'label': 'Settings Building'},
    {'imagePath': 'assets/images/4.png', 'label': 'Music Radio'},
    {'imagePath': 'assets/images/5.png', 'label': 'Volume Radio'},
    {'imagePath': 'assets/images/6.png', 'label': 'Home Radio'},
    {'imagePath': 'assets/images/7.png', 'label': 'Radio Podcast'},
    {'imagePath': 'assets/images/8.png', 'label': 'Settings Top'},
  ];

  // Method to generate random heights for staggered layout
  double _getRandomHeight() {
    final random = Random();
    return 150.0 + random.nextInt(150); // Random height between 150 and 300
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackCustomAppBar(
        screenTitle: screenTitle,
        backPress: () {
          Navigator.of(context).pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addVerticalSpace(10),
            const AnimatedText(
              text:'Hi Mary',
              size: 28,
              fontWeight: FontWeight.w600,
            ),
            addVerticalSpace(8),

            const AnimatedSlideText(
              text:'Lets select your perfect place',
              size: 28,
              fontWeight: FontWeight.w600,
            ),
            addVerticalSpace(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AnimatedContainerNoOpacity(
                    maxWidth: MediaQuery.of(context).size.width * 0.4,
                    maxHeight: MediaQuery.of(context).size.width * 0.4,
                    bgColor: AppColors.primaryColor,
                    isCircle: true,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(300), // Circular radius
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const AnimatedText(
                          text: 'BUY',
                          size: 14,
                          color: AppColors.textColor2,
                        ),
                        TweenAnimationBuilder<int>(
                          tween: IntTween(begin: 0, end: 1023), // Count from 0 to 2000
                          duration: const Duration(seconds: 2),
                          builder: (context, value, child) {
                            return AppText(
                              text: '$value',
                              size: 30,
                              color: AppColors.textColor2,
                            );
                          },
                        ),
                        const AnimatedText(
                          text: 'offers',
                          size: 14,
                          color: AppColors.textColor2,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: AnimatedContainerExpand(
                    maxWidth: MediaQuery.of(context).size.width * 0.4,
                    maxHeight: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const AppText(
                          text: 'RENT ',
                          size: 14,
                          color: AppColors.captionColor,
                        ),
                        TweenAnimationBuilder<int>(
                          tween: IntTween(begin: 0, end: 2000), // Count from 0 to 2000
                          duration: const Duration(seconds: 2),
                          builder: (context, value, child) {
                            return AppText(
                              text:'$value',
                              size: 30,
                              color: AppColors.captionColor,
                            );
                          },
                        ),
                        const AppText(
                          text: 'offers',
                          size: 14,
                          color: AppColors.captionColor,
                        ),
                      ],
                    ),

                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Fixed height scrollable container for grid items
            Container(
              height: 400, // Set fixed height for the grid view
              child: ListView(
                children: [
                  Wrap(
                    spacing: 8.0, // Space between items horizontally
                    runSpacing: 16.0, // Space between items vertically
                    children: List.generate(gridData.length, (index) {
                      // Generate random height for each item
                      double itemHeight = _getRandomHeight();

                      // For staggered view, alternate large and small items
                      return _buildGridItem(gridData[index], itemHeight);
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build individual grid items with flexible heights
  Widget _buildGridItem(Map<String, dynamic> item, double itemHeight) {
    return Container(
      width: (MediaQuery.of(context).size.width / 2) - 20, // Half of screen width minus padding
      height: itemHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              item['imagePath'],
              width: double.infinity,
              height: itemHeight - 40, // Subtract some height for the label space
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item['label'],
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
