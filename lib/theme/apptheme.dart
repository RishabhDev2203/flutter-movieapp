import 'package:flutter/material.dart';

import '../util/app_colors.dart';

class Themes {
  static const double APPBAR_ELEVATION = 10;
  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: Color(0xFF031038),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
    buttonColor: Colors.white,
    // fontFamily: 'Georgia',
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
      headline2: TextStyle(
        fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.white,),
      headline3: TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.redAccent),
      headline4: TextStyle(fontSize: 16.0,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          overflow: TextOverflow.ellipsis),
      headline5: TextStyle(fontSize: 15.0,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
          overflow: TextOverflow.ellipsis),
      labelMedium: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
      headline6: TextStyle(
          fontSize: 13.0, fontWeight: FontWeight.w400, color: Colors.white54),

      bodyText1: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: Colors.redAccent),
    ),


  );

  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: Colors.teal[100],
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white12,
    buttonColor: Colors.black,
    // fontFamily: 'Georgia',
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.black),
      headline2: TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black),
      headline3: TextStyle(
          fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.redAccent),
      headline4: TextStyle(fontSize: 16.0,
          fontWeight: FontWeight.w800,
          color: Colors.black,
          overflow: TextOverflow.ellipsis),
      headline5: TextStyle(fontSize: 15.0,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
          overflow: TextOverflow.ellipsis),
      labelMedium: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
      headline6: TextStyle(
          fontSize: 13.0, fontWeight: FontWeight.w400, color: Colors.black87),

      bodyText1: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w500, color: Colors.redAccent),
    ),
  );
}