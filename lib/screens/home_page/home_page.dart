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


class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _counter = 0;
  String screenTitle = 'Ekeja';
  Random random = Random();
  bool showGrid = false;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

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
    return 150.0 + random.nextInt(150);
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xFFFFA500), // Orange color
            ],
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpace(10),
                  const AnimatedText(
                    text: 'Hi, Mary',
                    size: 28,
                    fontWeight: FontWeight.w600,
                    color: AppColors.captionColor,
                  ),
                  addVerticalSpace(8),
                  const TextRevealAnimation(
                    text: "let's select your perfect place",
                    fontSize: 28.0,
                    color: Colors.black,
                    duration: Duration(milliseconds: 3000),
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
                            borderRadius: BorderRadius.circular(300),
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
                                tween: IntTween(begin: 0, end: 1023),
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
                          bgColor: AppColors.cardColor,
                          onAnimationComplete: () {
                            setState(() {
                              showGrid = !showGrid;
                            });
                          },
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
                                tween: IntTween(begin: 0, end: 2000),
                                duration: const Duration(seconds: 2),
                                builder: (context, value, child) {
                                  return AppText(
                                    text: '$value',
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
                ],
              ),
            ),
            // Animated slide-in grid positioned at the bottom
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              // Slide out of view if not showing
              bottom: showGrid ? 0 : -500,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.64,
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      spreadRadius: 2,
                      blurRadius: 1,
                      offset: const Offset(0, 0),
                    ),
                  ],                ),
                child: ListView(
                  children: [
                    Center(
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 6.0,
                        children: List.generate(gridData.length, (index) {
                          // Generate random height for each item
                          double itemHeight = _getRandomHeight();
                          return _buildGridItem(gridData[index], itemHeight);
                        }),
                      ),
                    ),
                  ],
                ),
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
      width: (MediaQuery.of(context).size.width / 2) - 12,
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
      child:Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: Image.asset(
              item['imagePath'],
              width: double.infinity,
              height: itemHeight,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              color: Colors.black.withOpacity(0.5),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item['label'],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      )
    );
  }
}