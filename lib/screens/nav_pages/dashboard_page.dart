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

class DashboardState extends State<Dashboard> {

  /// This global key is used to access the state of the navigator
  ///associated with the WillPopScope.
  /// It allows you to manipulate the navigation stack.
  // final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  List<Widget> pages = [
    const MapSearch(),
    const MessageScreen(),
    const HomePage(title: 'Real Estate'),
    const Favourites(),
    const SettingsScreen(),
  ];

  int currentIndex = 2;

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
          // If on the first screen, close the app
          SystemNavigator.pop();
          // Prevent default back button behavior
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
        child: Stack(
          children: [
            Scaffold(
              body: IndexedStack(
                index: currentIndex,
                children: pages,
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Theme.of(context).primaryColor,
                selectedFontSize: 14.0,
                unselectedFontSize: 14.0,
                onTap: onTap,
                currentIndex: currentIndex,
                selectedItemColor: AppColors.primaryColor,
                unselectedItemColor: AppColors.captionColor.withOpacity(0.5),
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w300),
                showUnselectedLabels: true,
                showSelectedLabels: true,
                elevation: 4,
                items: const [
                  BottomNavigationBarItem(
                      label: '',
                      icon: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Icon(
                          Icons.search,
                          // color: Theme.of(context).dividerColor,
                        ),
                      )),
                  BottomNavigationBarItem(
                      label: '',
                      icon: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Icon(
                          Icons.bar_chart,
                          // color: Theme.of(context).dividerColor,
                        ),
                      )),
                  BottomNavigationBarItem(
                    label: '',
                      icon: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Icon(
                          Icons.home_filled,
                          // color: Theme.of(context).dividerColor,
                        ),
                      )),
                  BottomNavigationBarItem(
                      label: '',
                      icon: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Icon(
                          Icons.favorite_sharp,
                          // color: Theme.of(context).dividerColor,
                        ),
                      )),
                  BottomNavigationBarItem(
                      label: '',
                      icon: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Icon(
                          Icons.person,
                          // color: Theme.of(context).dividerColor,
                        ),
                      )),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}