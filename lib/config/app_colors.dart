import 'package:flutter/material.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 10/10/21 at 6:41 pm
///

mixin AppColors {
  static const Color primary = Color(0xFF850A25);
  static const Color primaryLight = Color(0xFFD69BA9);
  static const Color red = Colors.red;

  static const MaterialColor brightPrimary =
      MaterialColor(_mcgpalette0PrimaryValue, <int, Color>{
    50: Color(0xFFF0E2E5),
    100: Color(0xFFDAB6BE),
    200: Color(0xFFC28592),
    300: Color(0xFFAA5466),
    400: Color(0xFF972F46),
    500: Color(_mcgpalette0PrimaryValue),
    600: Color(0xFF7D0921),
    700: Color(0xFF72071B),
    800: Color(0xFF680516),
    900: Color(0xFF55030D),
  });
  static const int _mcgpalette0PrimaryValue = 0xFF850A25;
}
