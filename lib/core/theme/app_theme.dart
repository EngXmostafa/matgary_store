import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
    ),
    textTheme: TextTheme(
        bodySmall: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins',
        ),
        titleMedium: TextStyle(
          color: AppColors.blackColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          fontFamily: 'Poppins',
        )
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.primaryColor,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
    ),
    textTheme: TextTheme(
      bodySmall: TextStyle(
        color: AppColors.primaryColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins',
      ),
      titleMedium: TextStyle(
        color: AppColors.blackColor,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Poppins',
      )
    ),
  );
}
