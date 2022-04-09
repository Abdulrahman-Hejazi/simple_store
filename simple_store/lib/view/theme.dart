import 'package:flutter/material.dart';

final customThemeData = ThemeData(

  appBarTheme: AppBarTheme(
    color: Color(0xff00A82B)
  ),
    textTheme: TextTheme(
        bodyMedium: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        labelMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        bodySmall: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 13, color: Colors.black87)),
    primaryColor: Color(0xffED1B24),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Color(0xffED1B24),
        unselectedItemColor: Color(0xffEEEEEE),
      backgroundColor: Color(0xff00A82B),
    ),
    scaffoldBackgroundColor: Color(0xffEEEEEE),
    backgroundColor: Color(0xffd4d4d4));
