import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            color: Colors.black, fontSize: 45, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(
            color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w300),
        displayMedium: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(
            color: Color.fromARGB(255, 224, 228, 220),
            fontSize: 16,
            fontWeight: FontWeight.w400),
      ));
}
