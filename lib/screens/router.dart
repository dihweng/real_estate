
import 'package:flutter/material.dart';
import 'package:real_estate/screens/home_page/home_page.dart';
import 'package:real_estate/screens/nav_pages/favourites.dart';
import 'package:real_estate/screens/splash_screen/splash_screen.dart';

import '../utils/route_name.dart';
import 'nav_pages/dashboard_page.dart';
import 'nav_pages/map_search_screen.dart';
import 'nav_pages/settings_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RouteName.dashboard:
        return MaterialPageRoute(builder: (_) => const Dashboard());

      case RouteName.mapSearch:
            return MaterialPageRoute(builder: (_) => const MapSearch());
      case RouteName.settingsScreen:
            return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case RouteName.favouriteScreen:
                  return MaterialPageRoute(builder: (_) => const Favourites());

      case RouteName.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage(title: '',));

      default:
        return MaterialPageRoute(builder: (_) => const Dashboard());
    }
  }
}
