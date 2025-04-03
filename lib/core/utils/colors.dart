// ignore_for_file: constant_identifier_names,avoid_classes_with_only_static_members
import 'package:flutter/material.dart';

abstract class GradientColors {
  static const primary = [
    Color(0xFF822FA3),
    Color(0xFFEF5984),
    Color(0xFFFF3F5C),
  ];

  static const darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
    colors: [AppColors.primary, Colors.transparent],
  );
}

abstract class AppColors {




  static bool isLightTheme = false;
  static const primary = Color(0xFF9C4613);
  static const primary2 = Color(0xFFE2DACF);
  static const appButtonBG = Color(0xFF9C4613);
  static const darkBrown = Color(0xFF361807);
  static const scaffoldBackgroundColor = Color(0xFFF8F3EA);
  static const buttonBackground = Color(0xFF9C4613);
  static const disableColor = Color(0x70333333);
  static const buttonText = Color(0xFFFFFFFF);
  static const transparent = Color(0xFF00000000);
  static const hintTextColor = Color(0x5070333333);
  static const errorColor = Color(0xFFDD0000);


  static const darkTextColor = Color(0xFF9C4613);
  static const blackTextColor = Color(0xFF333333);
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const borderColor = Color(0xFF9C4613);
  static const dividerColor = Color(0x15000000);
  static const shadowColor = Color(0x109C4613);
  static const green = Color(0xFF34C759);
  static const orange = Color(0xFFFF9500);





}
