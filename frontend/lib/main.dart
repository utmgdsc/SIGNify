import 'package:flutter/material.dart';
import 'package:frontend/settings.dart';
import 'package:frontend/camera_screen.dart';

void main() {
  runApp(const MyApp());
}

// Custom Green for app
Map<int, Color> primary =
{
  50:const Color.fromRGBO(17,138,126, .1),
  100:const Color.fromRGBO(17,138,126, .2),
  200:const Color.fromRGBO(17,138,126, .3),
  300:const Color.fromRGBO(17,138,126, .4),
  400:const Color.fromRGBO(17,138,126, .5),
  500:const Color.fromRGBO(17,138,126, .6),
  600:const Color.fromRGBO(17,138,126, .7),
  700:const Color.fromRGBO(17,138,126, .8),
  800:const Color.fromRGBO(17,138,126, .9),
  900:const Color.fromRGBO(17,138,126, 1),
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialColor themeColour = MaterialColor(0xFF118A7E, primary);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: themeColour,
      ),
      darkTheme: ThemeData.dark(), // default dark theme, only when we have too
      themeMode: ThemeMode.system,
      home: const CameraScreen(),
      //home: MySettingsPage(theme: themeColour,), // uncomment when settings button is made then we can reroute to settings page
    );
  }
}
