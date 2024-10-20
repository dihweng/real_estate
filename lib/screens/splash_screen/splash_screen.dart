import 'dart:async';
import 'package:flutter/material.dart';

import '../../locator.dart';
import '../../services/error_state.dart';
import '../../utils/colors.dart';
import '../../utils/local_store.dart';
import '../../utils/route_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with TickerProviderStateMixin{
  // final ErrorState _errorStateCtrl = locator<ErrorState>();

  //Listen to the error stream
  // late StreamSubscription<ErrorStatus> errorStateSub;

  @override
  void initState() {
    super.initState();
    // errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);

    Future.delayed(const Duration(milliseconds: 2500), () async {
      getUserDetailsLocalStorage();
    });
  }

  Future getUserDetailsLocalStorage() async {
    LocalStoreHelper localStoreHelper = LocalStoreHelper();

    const value = 'User1';//await LocalStoreHelper.getUserToken();

    if (!mounted) return;
    if (value.isNotEmpty) {
      return Navigator.of(context).pushNamedAndRemoveUntil(
          RouteName.dashboard, (Route<dynamic> route) => false);
    } else {
      return Navigator.of(context).pushNamedAndRemoveUntil(
          RouteName.dashboard, (Route<dynamic> route) => false);
    }
  }


  @override
  void dispose() {
    super.dispose();
    // errorStateSub.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: Semantics(
              label: 'Splash screen',
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                      color: AppColors.primaryColor,
                      child: Center(
                        child: SizedBox(
                            width: 90,
                            height: 167,
                            child:
                            Image.asset("assets/images/logo.png")),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
