import 'package:flutter/material.dart';
import 'package:frontend/customTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _themeData;
  // Status of dark mode
  late bool _isDark;
  // Use to update current theme to local file
  late String _color;
  // Use to store previous theme when switching to dark mode
  late ThemeData _prevTheme;
  // Method to retrieve themeData
  ThemeData get getTheme => _themeData;

  // Constructor
  ThemeNotifier(this._themeData) {
    getPreferences();
  }

  // Retrieve and store local data
  getPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _isDark = sharedPreferences.getBool('isDark') ?? false;
    _color = sharedPreferences.getString('ThemeColor') ?? 'default';
    _prevTheme = _isDark ? defaultTheme : currentTheme;
  }

  // Change between dark mode and light mode
  changeThemeMode() async {
    // Change to light mode, update isDark status in local file
    if (_isDark) {
      _isDark = false;
      _themeData = _prevTheme;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setBool('isDark', false);
      // Change to dark mode, update isDark status in local file
    } else {
      _isDark = true;
      _themeData = ThemeData.dark();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setBool('isDark', true);
    }
    // Tell app to update theme
    notifyListeners();
  }

  // Update theme color to app
  setThemeColor(ThemeData themeData, String color) async {
    _themeData = themeData;
    _prevTheme = _themeData;
    _color = color;
    // Store current theme to local file
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('ThemeColor', _color);
    notifyListeners();
  }
}
