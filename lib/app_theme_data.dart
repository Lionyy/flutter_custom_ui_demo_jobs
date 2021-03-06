import 'package:flutter/material.dart';

class AppThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFB93C5D),
    primaryVariant: Color(0xFF117378),
    secondary: Color(0xFFEFF3F3),
    secondaryVariant: Color(0xFFFAFBFB),
    background: Color(0xFFE6EBEB),
    surface: Color(0xFFFAFBFB),
    onBackground: Colors.white,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFFF8383),
    primaryVariant: Color(0xFF1CDEC9),
    secondary: Color(0xFF4D1F7C),
    secondaryVariant: Color(0xFF451B6F),
    background: Color(0xFF241E30),
    surface: Color(0xFF1F1929),
    onBackground: Color(0x0DFFFFFF), // White with 0.05 opacity
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  static final lightThemeData = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.cyan[900],//主题色为蓝色
      accentColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.blue),
      tabBarTheme: TabBarTheme(labelColor: Colors.white),
      textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black), bodyText2: TextStyle(color: Colors.black)),
      colorScheme: lightColorScheme,
      focusColor: _lightFocusColor,
    );

  static final darkThemeData = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.blueGrey[900],//主题色为蓝色
      accentColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.yellow),
      tabBarTheme: TabBarTheme(labelColor: Colors.white),
      textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white), bodyText2: TextStyle(color: Colors.white)),
      colorScheme: darkColorScheme,
      focusColor: _darkFocusColor,
    );
}