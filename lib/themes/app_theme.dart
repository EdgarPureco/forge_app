import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryColor = const Color.fromARGB(255, 204, 0, 0);
  static Color secondaryColor = const Color.fromARGB(255, 59, 76, 202);
  static Color tertiaryColor = const Color.fromARGB(255, 255, 222, 0);
  static ThemeData lightThemeData = ThemeData.light().copyWith(
      primaryColor: primaryColor,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(color: secondaryColor, elevation: 2),
      scaffoldBackgroundColor: Colors.white);
  static ThemeData nightThemeData = ThemeData.dark().copyWith(
      primaryColor: secondaryColor,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(color: tertiaryColor, elevation: 2),
      scaffoldBackgroundColor: Colors.grey);
  static InputDecoration baseInput(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon}) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.secondaryColor)),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppTheme.secondaryColor, width: 2)),
      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.grey),
      prefix: prefixIcon != null
          ? Icon(
              prefixIcon,
              color: AppTheme.tertiaryColor,
            )
          : null,
    );
  }
}
