import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../theme/app_theme.dart';
import 'colors.dart';

String naira = String.fromCharCodes(Runes('\u{20A6}'));

const double squareSize = 60.0;
const int length = 3;
const double strokeWidth = 250.0;
const double strokeHeight = 10.0;
const double spacing = 8.0;


Widget addVerticalSpace(double height) {
  return SizedBox(height: height);
}

Widget addHorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

BoxShadow generateBoxShadow(BuildContext context) {
  final isDarkMode = Provider.of<AppTheme>(context).themeMode == ThemeMode.dark;
  final isLightMode = Provider.of<AppTheme>(context).themeMode == ThemeMode.dark;
  if(isDarkMode == true) {
    return BoxShadow(
      color: Theme.of(context).primaryColor,
      blurRadius: 5.0,
      blurStyle: BlurStyle.normal,
      spreadRadius: 0.0,
      offset: const Offset(0.0, 0.2),
    );
  }
  if(isLightMode == true) {
    return const BoxShadow(
      color: AppColors.shadowColor,
      blurRadius: 5.0,
      blurStyle: BlurStyle.normal,
      spreadRadius: 0.0,
      offset: Offset(0.0, 0.2),
    );
  }
  return BoxShadow(
    color: Colors.black.withOpacity(0.05),
    blurRadius: 5.0,
    blurStyle: BlurStyle.normal,
    spreadRadius: 0.0,
    offset: const Offset(0.0, 0.2),
  );
}

