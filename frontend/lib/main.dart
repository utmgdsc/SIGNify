import 'package:flutter/material.dart';
import 'package:frontend/custom_theme.dart';
import 'package:frontend/home.dart';
import 'package:frontend/theme_model.dart';
import 'package:frontend/user_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'camera_screen.dart';

void main() {
  // Initialize widget binding
  WidgetsFlutterBinding.ensureInitialized();
  // Access app local data
  SharedPreferences.getInstance().then((sharedPreferences) {
    // Get local data with key
    String color = sharedPreferences.getString('ThemeColor') ?? "default";
    bool isDark = sharedPreferences.getBool('isDark') ?? false;
    String userId = sharedPreferences.getString("userId") ?? "";

    // Set theme color according to local data
    if (color == 'pink') {
      currentTheme = createThemeData(Colors.pink, isDark);
    } else if (color == 'orange') {
      currentTheme = createThemeData(Colors.orange, isDark);
    } else if (color == 'brown') {
      currentTheme = createThemeData(Colors.brown, isDark);
    } else if (color == 'lightBlue') {
      currentTheme = createThemeData(Colors.lightBlue, isDark);
    } else if (color == 'purple') {
      currentTheme = createThemeData(Colors.purple, isDark);
    } else {
      currentTheme = createThemeData(defaultColor, isDark);
    }

    runApp(
      // Used for multiple provider, provider can be shared in all pages
      MultiProvider(
        providers: [
          // user_info class
          Provider(create: (context) => UserInfo(userId)),
          // theme_model class
          ChangeNotifierProvider(
              create: (context) => ThemeNotifier(currentTheme)),
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Create themeNotifier variable to access theme_model class method
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    // Create userInfo variable to access user_info class method
    final userInfo = Provider.of<UserInfo>(context);
    return MaterialApp(
        title: 'SIGNify',
        theme: themeNotifier.getTheme,
        home: userInfo.getUserId.isEmpty ? HomePage() : CameraScreen());
  }
}
