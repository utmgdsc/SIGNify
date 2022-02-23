import 'package:flutter/material.dart';
import 'package:frontend/customTheme.dart';
import 'package:frontend/camera_screen.dart';
import 'package:frontend/theme_model.dart';
import 'package:frontend/create_account.dart';
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
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Use provider class to update theme in real time
    return ChangeNotifierProvider(
      // Initialize theme model class
      create: (context) => ThemeNotifier(currentTheme),
      // Need to wrap with Consumer in order to use Provider feature
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) => MaterialApp(
          title: 'SIGNify',
          theme: themeNotifier.getTheme,
          home: CameraScreen(),
        ),
      ),
    );
  }
}