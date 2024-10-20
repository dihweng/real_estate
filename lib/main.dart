import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:real_estate/screens/router.dart';
import 'package:real_estate/services/api_services.dart';
import 'package:real_estate/theme/app_theme.dart';
import 'package:real_estate/utils/local_store.dart';
import 'package:real_estate/viewmodels/home_page_model.dart';

import 'locator.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void setStatusBarBrightness(BuildContext context) {
  Brightness statusBarBrightness;

  // Determine theme mode
  if (Theme.of(context).brightness == Brightness.dark) {
    statusBarBrightness = Brightness.dark;
  } else {
    statusBarBrightness = Brightness.light;
  }

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: statusBarBrightness,
    ),
  );
}

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  await LocalStoreHelper.getTheme();

  await _setupDioApiClient();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppTheme>(create: (_) => AppTheme()),
        ChangeNotifierProvider<HomePageModel>(create: (_) => HomePageModel()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> _setupDioApiClient() async {
  await locator<ApiService>().clientSetup();
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  // RemoteConfigService remoteConfigService = RemoteConfigService();
  final GlobalKey<NavigatorState> navKey = GlobalKey();
  late StreamSubscription subscription;

  // bool initialToastShown = false;

  @override
  void initState() {
    super.initState();
    // remoteConfigService.initConfig();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppTheme>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiver',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      onGenerateRoute: Router.generateRoute,
      builder: (context, child) {
        return child!;
      },
    );
  }
}
