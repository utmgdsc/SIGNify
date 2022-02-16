import 'package:flutter/material.dart';

// Use to store local theme data temporarily
late ThemeData currentTheme;
// Custom Green for app
Map<int, Color> primary = {
  50: const Color.fromRGBO(17, 138, 126, .1),
  100: const Color.fromRGBO(17, 138, 126, .2),
  200: const Color.fromRGBO(17, 138, 126, .3),
  300: const Color.fromRGBO(17, 138, 126, .4),
  400: const Color.fromRGBO(17, 138, 126, .5),
  500: const Color.fromRGBO(17, 138, 126, .6),
  600: const Color.fromRGBO(17, 138, 126, .7),
  700: const Color.fromRGBO(17, 138, 126, .8),
  800: const Color.fromRGBO(17, 138, 126, .9),
  900: const Color.fromRGBO(17, 138, 126, 1),
};
// Main theme color
final defaultColor = MaterialColor(0xFF118A7E, primary);

// Main theme
final defaultTheme = ThemeData(
  primarySwatch: defaultColor,
);
