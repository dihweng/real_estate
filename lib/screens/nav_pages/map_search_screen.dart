import 'dart:async';


import 'package:flutter/material.dart';

import '../../locator.dart';
import '../../services/error_state.dart';
import '../../utils/colors.dart';
import '../../utils/local_store.dart';

class MapSearch extends StatefulWidget {
  const MapSearch({super.key});

  @override
  State<MapSearch> createState() => _MapSearchState();
}

class _MapSearchState extends State<MapSearch> with TickerProviderStateMixin{

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String name = 'Please enter your name here';
  String? email = '';
  String? phoneNumber = '';
  final _formkey = GlobalKey<FormState>();
  final ErrorState _errorStateCtrl = locator<ErrorState>();
  //Listen to the error stream
  late StreamSubscription<ErrorStatus> errorStateSub;
  late Stream<Map<String, dynamic>> userDetails = const Stream.empty();

  String getInitials(String fullName, [int limitTo = 2]) {
    if (fullName.isEmpty) {
      return fullName;
    }
    List<String> nameParts = fullName.split(" ");
    String initials = "";
    for (String part in nameParts) {
      if (part.isNotEmpty) {
        initials += part[0].toUpperCase();
      }
    }
    return initials;
  }


  @override
  void initState() {
    // errorStateSub = _errorStateCtrl.streamError.listen(_showErrorMessage);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   userDetails = Stream<Map<String, dynamic>>.fromFuture(getMeDetails())
    //       .map((response) => response);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.west,
            color: AppColors.captionColor,
          ),
        ),
      ),
      body: StreamBuilder<Map<String, dynamic>>(
          stream: userDetails,
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            final responseData = snapshot.data;
            return Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) =>
                    const SingleChildScrollView(
                  child: SizedBox(),
                ),
              ),
            );
          }),
    );
  }



}
