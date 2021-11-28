import 'package:flutter/material.dart';

import 'colors.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: AppColors.green,
    backgroundColor: AppColors.backgroundWhite,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    accentColor: AppColors.deepRed,
    dialogBackgroundColor: AppColors.green,
    buttonColor: AppColors.deepRed,
    snackBarTheme: SnackBarThemeData(actionTextColor: AppColors.deepRed,
    ),
  );
  final darkTheme = ThemeData.dark().copyWith(
      primaryColor: AppColors.deepRed,
      backgroundColor: AppColors.backgroundBlack,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black))));
}
