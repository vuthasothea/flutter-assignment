import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData light() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFA6A27C)),
      scaffoldBackgroundColor: Color.fromARGB(255, 233, 230, 204),
      appBarTheme: AppBarTheme(
        backgroundColor: Color.fromARGB(255, 233, 230, 204)
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: Color.fromARGB(255, 233, 230, 204)
      ),
      useMaterial3: true,
    );
  }

}