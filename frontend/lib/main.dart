import 'package:flutter/material.dart';
import 'package:frontend/customTheme.dart';
import 'package:frontend/camera_screen.dart';
import 'package:frontend/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((sharedPreferences) {
    var color = sharedPreferences.getString('ThemeColor');
    var isDark = sharedPreferences.getBool('isDark');

    if (color == 'pink') {
      currentTheme = ThemeData(primarySwatch: Colors.pink);
    } else if (color == 'orange') {
      currentTheme = ThemeData(primarySwatch: Colors.orange);
    } else if (color == 'brown') {
      currentTheme = ThemeData(primarySwatch: Colors.brown);
    } else if (color == 'lightBlue') {
      currentTheme = ThemeData(primarySwatch: Colors.lightBlue);
    } else if (color == 'purple') {
      currentTheme = ThemeData(primarySwatch: Colors.purple);
    } else {
      currentTheme = defaultTheme;
    }

    if (isDark != null && isDark) {
      currentTheme = ThemeData.dark();
    }

    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeNotifier(currentTheme),
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) => MaterialApp(
          title: 'SIGNify',
          theme: themeNotifier.getTheme,
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.system,
          home: CameraScreen(),
        ),
      ),
    );
  }
}
