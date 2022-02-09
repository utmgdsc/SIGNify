import 'package:flutter/material.dart';
import 'package:frontend/camera_screen.dart';

void main() {
  runApp(const MyApp());
}

// Custom Green for app
Map<int, Color> primary = {
  50: Color.fromRGBO(17, 138, 126, .1),
  100: Color.fromRGBO(17, 138, 126, .2),
  200: Color.fromRGBO(17, 138, 126, .3),
  300: Color.fromRGBO(17, 138, 126, .4),
  400: Color.fromRGBO(17, 138, 126, .5),
  500: Color.fromRGBO(17, 138, 126, .6),
  600: Color.fromRGBO(17, 138, 126, .7),
  700: Color.fromRGBO(17, 138, 126, .8),
  800: Color.fromRGBO(17, 138, 126, .9),
  900: Color.fromRGBO(17, 138, 126, 1),
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF118A7E, primary),
      ),
      darkTheme: ThemeData.dark(), // default dark theme, only when we have too
      themeMode: ThemeMode.system,
      home: const CameraScreen(),
    );
  }
}
