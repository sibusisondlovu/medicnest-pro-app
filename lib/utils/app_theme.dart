

import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.mainColor,
    hintColor: AppColors.ascentColor,
    scaffoldBackgroundColor: Colors.white,

  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.mainColor,
    hintColor: AppColors.ascentColor,
    scaffoldBackgroundColor: Colors.white,
  );
}