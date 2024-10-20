import 'dart:async';

import 'package:flutter/material.dart';

import '../../locator.dart';
import '../../services/error_state.dart';
import '../../utils/colors.dart';
import '../../utils/local_store.dart';
import '../../utils/route_name.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {


  final ErrorState _errorStateCtrl = locator<ErrorState>();

  /// Listen to the error stream
  late StreamSubscription<ErrorStatus> errorStateSub;

  @override
  void initState() {
    super.initState();
    // errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamed(RouteName.dashboard);
        return false;
      },
      child: SafeArea(
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                bottomOpacity: 0.0,
                elevation: 0.0,
                leading: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    // Set the left margin here
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 50,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.west,
                          size: 24,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              body: Semantics(
                label: 'List of Settings',
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.0, top: 4.0),
                          // child: QvHeaderText(
                          //   text: 'Setting Screens',//remoteConfig.getString('settings_title'),
                          // ),
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
