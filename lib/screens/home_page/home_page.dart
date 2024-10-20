import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {

  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(83, 0, 90, 1.0),
        // Remove the title
        title: null,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: IconButton(
              icon: const Icon(Icons.search, size: 30, color: Colors.white,),
              onPressed: () {
              },
            ),
          ),
          const Spacer(),

          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child:  Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset('assets/images/7.png', fit: BoxFit.contain,),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(83, 0, 90, 1.0), // Hex value for deep purple
              Color.fromRGBO(30, 0, 61, 1), // RGB values for purple
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Radio Station',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  itemCount: gridData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 items per row
                    crossAxisSpacing: 4.0, // Space between columns
                    mainAxisSpacing: 20.0, // Space between rows
                    childAspectRatio: 0.90, // // Space between rows
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    // Check if the index is at the center of the row
                    // bool isCenterItem = (index + 1) % 2 == 0;
                    return Column(
                      children: [
                        Container(
                          height: 88,
                          width: 88,
                          // margin: EdgeInsets.only(top: isCenterItem ? 20 : 0), // Add margin top if it's the center item
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(gridData[index]['imagePath'],
                            fit: BoxFit.contain,),
                        ),
                        // const SizedBox(height: 4,),
                        SizedBox(
                          width: 80,
                          child: Text(
                            gridData[index]['label'],
                            style: const TextStyle(color: Colors.white,),
                            maxLines: 2, // Set the maximum number of lines
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromRGBO(30, 0, 61, 1), // Adjust opacity as needed
        showSelectedLabels: false, // Hide the selected labels
        showUnselectedLabels: false, // Hide the unselected labels
        type: BottomNavigationBarType.fixed,
        // currentIndex: 0,
        // selectedItemColor: Colors.deepPurple, // Set the color for the selected item
        items: [
          _buildBottomNavigationBarItem('assets/images/music.png'),
          _buildBottomNavigationBarItem('assets/images/volume.png'),
          _buildBottomNavigationBarItem('assets/images/home.png'),
          _buildBottomNavigationBarItem('assets/images/podcast.png'),
          _buildBottomNavigationBarItem('assets/images/settings.png'),
        ],
      ),
    );
  }
  BottomNavigationBarItem _buildBottomNavigationBarItem(String imagePath) {
    return BottomNavigationBarItem(
      icon: ImageIcon(AssetImage(imagePath), color: Colors.white),
      label: '',
    );
  }
}