import 'package:flutter/material.dart';
import '../../widgets/back_custom_app_bar.dart';
import 'dart:math'; // For random height generation

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

  @override
  Widget build(BuildContext context) {
    // Split the grid data into odd and even indexed lists
    List<Map<String, dynamic>> oddItems = [];
    List<Map<String, dynamic>> evenItems = [];

    for (int i = 0; i < gridData.length; i++) {
      if (i % 2 == 0) {
        evenItems.add(gridData[i]);
      } else {
        oddItems.add(gridData[i]);
      }
    }

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
              Colors.white, // Start color of the gradient (white)
              Color(0xFFA5967E), // End color of the gradient (#a5967e)
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 0),
          child: ListView.builder(
            itemCount: gridData.length,
            itemBuilder: (BuildContext context, int index) {
              // Check if the current item should expand to the full width
              bool isFullWidth = index % 4 == 0; // Every 4th item expands full width
              double itemHeight = random.nextInt(100) + 150; // Dynamic height

              if (isFullWidth) {
                // For full-width items, return a single container that spans the entire width
                return _buildFullWidthItem(gridData[index], itemHeight);
              } else {
                // For half-width items, return a row with two staggered ListViews
                return Row(
                  children: [
                    // Odd items
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: (index % 2 == 0)
                            ? _buildHalfWidthItem(gridData[index], itemHeight)
                            : const SizedBox.shrink(),
                      ),
                    ),
                    // Even items
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: (index % 2 != 0)
                            ? _buildHalfWidthItem(gridData[index], itemHeight)
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  // Method to build full-width item
  Widget _buildFullWidthItem(Map<String, dynamic> item, double itemHeight) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      width: double.infinity, // Span full width
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          item['imagePath'],
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Method to build half-width item
  Widget _buildHalfWidthItem(Map<String, dynamic> item, double itemHeight) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
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
              height: itemHeight,
              fit: BoxFit.cover,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     item['label'],
          //     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          //   ),
          // ),
        ],
      ),
    );
  }
}
