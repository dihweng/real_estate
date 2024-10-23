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

import '../../widgets/expand_location_widget.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  // int _counter = 0;
  String screenTitle = 'Ekeja';
  Random random = Random();
  bool showGrid = false;

  // Controller for ExpandLocationWidget to track timing.
  late AnimationController _controller;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  List<Map<String, dynamic>> gridData = [
    {'imagePath': 'assets/images/1.png', 'label': 'Mirchi'},
    {'imagePath': 'assets/images/monday.png', 'label': 'Mirchi'},
    {'imagePath': 'assets/images/3.png', 'label': 'MeethiM'},
    {'imagePath': 'assets/images/5.png', 'label': 'Campus'},
    {'imagePath': 'assets/images/6.png', 'label': 'Club'},
    {'imagePath': 'assets/images/7.png', 'label': 'Indies'},
    {'imagePath': 'assets/images/8.png', 'label': 'Abuja'},
    {'imagePath': 'assets/images/9.png', 'label': 'Podcast'},
    {'imagePath': 'assets/images/10.png', 'label': 'Mirchi'},
    {'imagePath': 'assets/images/11.png', 'label': 'Lome'},
    {'imagePath': 'assets/images/12.png', 'label': 'Jabi'},
    {'imagePath': 'assets/images/1.png', 'label': 'Ekeja'},
    {'imagePath': 'assets/images/2.png', 'label': 'Limpopo'},
    {'imagePath': 'assets/images/3.png', 'label': 'Togo'},
    {'imagePath': 'assets/images/4.png', 'label': 'Mangu'},
    {'imagePath': 'assets/images/5.png', 'label': 'Fan'},
    {'imagePath': 'assets/images/6.png', 'label': 'Ogun'},
    {'imagePath': 'assets/images/7.png', 'label': 'Benue'},
    {'imagePath': 'assets/images/8.png', 'label': 'Testing'},
  ];

  // Method to generate random heights for staggered layout
  double _getRandomHeight() {
    final random = Random();
    return 150.0 + random.nextInt(150);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                    size: 20,
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
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
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
                  ],
                ),
                child: ListView(
                  children: [
                    Center(
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 6.0,
                        children: List.generate(gridData.length, (index) {
                          double itemHeight = _getRandomHeight();
                          return _buildGridItem(gridData[index], itemHeight);
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              onEnd: () {
                // Callback to trigger ExpandLocationWidget animation
                _controller.forward();
              },
            )

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
            child: ExpandLocationWidget(
              maxWidth: MediaQuery.of(context).size.width * 0.2,
              location: item['label'],
              backgroundColor: const Color.fromRGBO(255, 181, 17, 0.45),
              controller: _controller,
              child: Container(
                width: 30.0,
              height: 30.0,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: const Center(
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 12,),
                  ),
              ),  // Pass the controller or trigger method
            ),
          ),
        ],
      )
    );
  }
}

