import 'package:flutter/material.dart';

class AppThemes {


  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue.shade900,
    scaffoldBackgroundColor: Colors.blue.shade50,

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue.shade900,
      foregroundColor: Colors.white,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(

      bodyMedium: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.black),
      labelSmall: TextStyle(color: Colors.grey.shade700),//pubDate

    ),
    cardTheme: CardTheme(
        color: Colors.white
    ),
  );



  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    // scaffoldBackgroundColor: Colors.grey.shade800,
    scaffoldBackgroundColor: Colors.black45,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue.shade900,
      foregroundColor: Colors.white,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(

      bodyMedium: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      labelSmall: TextStyle(color: Colors.grey),//pubDate

    ),
    cardTheme: CardTheme(
      color: Colors.grey.shade700
    ),


  );
}
