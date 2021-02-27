import 'package:flutter/material.dart';

class AppThemeData {
  static final lightThemeData = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.cyan[900],//主题色为蓝色
      accentColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.blue),
      tabBarTheme: TabBarTheme(labelColor: Colors.white),
      textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black), bodyText2: TextStyle(color: Colors.black))
    );

  static final darkThemeData = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.blueGrey[900],//主题色为蓝色
      accentColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.yellow),
      tabBarTheme: TabBarTheme(labelColor: Colors.white),
      textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white), bodyText2: TextStyle(color: Colors.white))
    );
}