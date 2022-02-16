import 'package:flutter/material.dart';
import 'package:frontend/customTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _themeData;
  late bool _isDark;
  late String _color;
  late ThemeData _prevTheme;
  ThemeData get getTheme => _themeData;

  ThemeNotifier(this._themeData) {
    getPreferences();
  }

  getPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _isDark = sharedPreferences.getBool('isDark') ?? false;
    _color = sharedPreferences.getString('ThemeColor') ?? 'default';
    _prevTheme = _isDark ? defaultTheme : currentTheme;
  }

  changeThemeMode() async {
    if (_isDark) {
      _isDark = false;
      _themeData = _prevTheme;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setBool('isDark', false);
    } else {
      _isDark = true;
      _themeData = ThemeData.dark();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setBool('isDark', true);
    }
    notifyListeners();
  }

  setThemeColor(ThemeData themeData, String color) async {
    _themeData = themeData;
    _prevTheme = _themeData;
    _color = color;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('ThemeColor', _color);
    notifyListeners();
  }
}
