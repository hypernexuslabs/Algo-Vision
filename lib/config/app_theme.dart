///
/// Created by Auro (auro@smarttersstudio.com) on 10/10/21 at 9:03 pm
///

import 'package:flutter/material.dart';

import 'app_colors.dart';

mixin AppThemes {
  static final lightTheme = ThemeData(
    primarySwatch: AppColors.brightPrimary,
    primaryColor: AppColors.brightPrimary,
    accentColor: AppColors.brightPrimary,
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.brightPrimary,
        selectionHandleColor: AppColors.brightPrimary,
        selectionColor: AppColors.brightPrimary.withOpacity(0.3)),
    iconTheme: const IconThemeData(color: Colors.black),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      brightness: Brightness.dark,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(primary: AppColors.brightPrimary),
    ),
    // textTheme: TextTheme(
    //   bodyText1:
    //       TextStyle(color: Color(0xff2A2A2A), fontFamily: 'Rubik'),
    //   bodyText2:
    //       TextStyle(color: Color(0xff2A2A2A), fontFamily: 'Rubik'),
    // ),
  );
}
