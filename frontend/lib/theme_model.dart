import 'package:flutter/material.dart';
import 'package:frontend/customTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _themeData;
  // Status of dark mode
  late bool _isDark;
  // Use to update current theme to local file
  late String _colorName;
  // Use to store current color theme
  late MaterialColor _color;
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
    _colorName = sharedPreferences.getString('ThemeColor') ?? 'default';
    if (_colorName == 'pink') {
      _color = Colors.pink;
    } else if (_colorName == 'orange') {
      _color = Colors.orange;
    } else if (_colorName == 'brown') {
      _color = Colors.brown;
    } else if (_colorName == 'lightBlue') {
      _color = Colors.lightBlue;
    } else if (_colorName == 'purple') {
      _color = Colors.purple;
    } else {
      _color = defaultColor;
    }
  }

  // Change between dark mode and light mode
  changeThemeMode() async {
    // Change _isDark variable value
    if (_isDark) {
      _isDark = false;
    } else {
      _isDark = true;
    }
    // Set new theme data
    _themeData = createThemeData(_color, _isDark);
    // Update isDark variable in local file
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('isDark', _isDark);
    // Tell app to update theme
    notifyListeners();
  }

  // Update theme color to app
  setThemeColor(MaterialColor color, String colorName) async {
    _color = color;
    _themeData = createThemeData(color, _isDark);
    _colorName = colorName;
    // Store current theme to local file
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('ThemeColor', _colorName);
    notifyListeners();
  }
}
