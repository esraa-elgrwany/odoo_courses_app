import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

class MyThemeData {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: primaryColor,
        onPrimary: Colors.white,
        secondary: secondPrimary,
        onSecondary: thirdPrimary,
        error: Colors.red,
        onError: Colors.white,
        background: Colors.white,
        onBackground: Colors.grey[100],
        surface: primaryColor,
        onSurface: Colors.black),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        elevation: 0,
        shadowColor: Colors.transparent,
        titleTextStyle: TextStyle(
            color: Colors.black87, fontSize: 22, fontWeight: FontWeight.w500),
        actionsIconTheme: IconThemeData(color: Colors.white)),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.white,
        onPrimary: Colors.white,
        secondary: Colors.black54,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        background: Colors.black87,
        onBackground: Colors.black54,
        surface:Colors.black54,
        onSurface: Colors.white),
    scaffoldBackgroundColor: Colors.black87,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.black87,
        elevation: 0,
        shadowColor: Colors.transparent,
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
        actionsIconTheme: IconThemeData(color: Colors.white)),
  );
}
