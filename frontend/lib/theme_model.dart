import 'package:flutter/material.dart';
import 'package:frontend/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _themeData;
  // Status of dark mode
  late bool _isDark;
  // Use to update current theme to local file
  late String _colorName;
  // Use to store current color theme
  late MaterialColor _color;
  late double _fontSize;
  // Method to retrieve themeData
  ThemeData get getTheme => _themeData;

  // Constructor
  ThemeNotifier(this._themeData) {
    getPreferences();
  }

  // Retrieve and store local data
  void getPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _isDark = sharedPreferences.getBool('isDark') ?? false;
    _colorName = sharedPreferences.getString('ThemeColor') ?? 'default';
    _fontSize = sharedPreferences.getDouble('fontSize') ?? 15;
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
  void changeThemeMode() async {
    // Change _isDark variable value
    if (_isDark) {
      _isDark = false;
    } else {
      _isDark = true;
    }
    // Set new theme data
    _themeData = createThemeData(_color, _isDark, _fontSize);
    // Update isDark variable in local file
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('isDark', _isDark);
    // Tell app to update theme
    notifyListeners();
  }

  // Update theme color to app
  void setThemeColor(MaterialColor color, String colorName) async {
    _color = color;
    _themeData = createThemeData(color, _isDark, _fontSize);
    _colorName = colorName;
    // Store current theme to local file
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('ThemeColor', _colorName);
    notifyListeners();
  }

  setFontSize(double fontSize) async {
    _fontSize = fontSize;
    _themeData = createThemeData(_color, _isDark, _fontSize);
    // Store font size to local file
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setDouble('fontSize', _fontSize);
    notifyListeners();
  }

  double getFontSize() {
    return _fontSize;
  }
}
