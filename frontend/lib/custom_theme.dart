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

// Generate custom theme
ThemeData createThemeData(MaterialColor color, bool isDark, double fontSize) {
  if (isDark) {
    return ThemeData(
      primarySwatch: color,
      brightness: Brightness.dark,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: color,
        foregroundColor: Colors.black,
      ),
      textTheme: TextTheme(bodyText1: TextStyle(fontSize: fontSize), bodyText2: TextStyle(fontSize: fontSize), button: TextStyle(fontSize: fontSize), 
                           headline1: TextStyle(fontSize: fontSize), headline2: TextStyle(fontSize: fontSize), headline3: TextStyle(fontSize: fontSize), headline4: TextStyle(fontSize: fontSize), headline5: TextStyle(fontSize: fontSize), headline6: TextStyle(fontSize: fontSize),)
    );
  } else {
    return ThemeData(
      primarySwatch: color,
      brightness: Brightness.light,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
      textTheme: TextTheme(bodyText1: TextStyle(fontSize: fontSize), bodyText2: TextStyle(fontSize: fontSize), button: TextStyle(fontSize: fontSize),
                          headline1: TextStyle(fontSize: fontSize), headline2: TextStyle(fontSize: fontSize), headline3: TextStyle(fontSize: fontSize), headline4: TextStyle(fontSize: fontSize), headline5: TextStyle(fontSize: fontSize), headline6: TextStyle(fontSize: fontSize),)
    );
  }
}
