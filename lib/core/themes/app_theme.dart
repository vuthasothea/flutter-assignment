import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData light() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color(0xFFA6A27C),
        surface: Color.fromARGB(255, 255, 253, 235)
      ),
      scaffoldBackgroundColor: Color.fromARGB(255, 233, 230, 204),
      appBarTheme: AppBarTheme(
        backgroundColor: Color.fromARGB(255, 233, 230, 204)
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: Color.fromARGB(255, 233, 230, 204)
      ),
      brightness: Brightness.light,
      useMaterial3: true,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,      
      useMaterial3: true
    );
  }

}