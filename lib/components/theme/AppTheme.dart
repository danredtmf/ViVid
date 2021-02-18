import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blueAccent,

    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.blueAccent,
      iconTheme: IconThemeData(
        color: Colors.black87,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.black87
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black87,
        fontSize: 20,
      ),
      subtitle2: TextStyle(
        color: Colors.black45,
        fontSize: 18,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.white12,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.white
    ),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      subtitle2: TextStyle(
        color: Colors.white70,
        fontSize: 18,
      ),
    ),
  );
}