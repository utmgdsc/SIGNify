import 'package:flutter/material.dart';
import 'package:frontend/custom_theme.dart';
import 'package:frontend/camera_screen.dart';
import 'package:frontend/settings.dart';
import 'package:frontend/home.dart';
import 'package:frontend/theme_model.dart';
import 'package:frontend/user_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // Initialize widget binding
  WidgetsFlutterBinding.ensureInitialized();
  // Access app local data
  SharedPreferences.getInstance().then((sharedPreferences) {
    // Get local data with key
    var color = sharedPreferences.getString('ThemeColor');
    var isDark = sharedPreferences.getBool('isDark') ?? false;
    var fontSize = sharedPreferences.getDouble('fontSize') ?? 15;
    String userId = sharedPreferences.getString("userId") ?? "";

    // Set theme color according to local data
    if (color == 'pink') {
      currentTheme = createThemeData(Colors.pink, isDark, fontSize);
    } else if (color == 'orange') {
      currentTheme = createThemeData(Colors.orange, isDark, fontSize);
    } else if (color == 'brown') {
      currentTheme = createThemeData(Colors.brown, isDark, fontSize);
    } else if (color == 'lightBlue') {
      currentTheme = createThemeData(Colors.lightBlue, isDark, fontSize);
    } else if (color == 'purple') {
      currentTheme = createThemeData(Colors.purple, isDark, fontSize);
    } else {
      currentTheme = createThemeData(defaultColor, isDark, fontSize);
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
    final userInfo = Provider.of<UserInfo>(context);
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    // Use provider class to update theme in real time
    return MaterialApp(
        title: 'SIGNify',
        theme: themeNotifier.getTheme,
        home: userInfo.getUserId.isEmpty ? HomePage() : CameraScreen());
  }
}
