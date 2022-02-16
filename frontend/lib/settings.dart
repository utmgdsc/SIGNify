import 'package:flutter/material.dart';
import 'package:frontend/theme_model.dart';
import 'package:provider/provider.dart';

import 'customTheme.dart';

class MySettingsPage extends StatefulWidget {
  const MySettingsPage({Key? key}) : super(key: key);

  @override
  _MySettingsPageState createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  @override
  Widget build(BuildContext context) {
    // Create themeNotifier variable to access theme_model method
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    themeNotifier.getTheme;

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Settings"),
      ),
      body: Container(
        // Space between appBar and menu
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          // Stretch button to full width
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // History button
            TextButton.icon(
              icon: const Icon(
                Icons.access_time,
                size: 24.0,
              ),
              label: const Text(
                "History",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(left: 15),
                  alignment: Alignment.centerLeft),
              onPressed: () {},
            ),
            // Dark/Light theme button
            TextButton.icon(
              icon: const Icon(
                Icons.mode_night_outlined,
                size: 24.0,
              ),
              label: const Text(
                "Dark/Light Mode",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(left: 15),
                  alignment: Alignment.centerLeft),
              onPressed: () {
                themeNotifier.changeThemeMode();
              },
            ),
            // Theme Color button
            TextButton.icon(
              icon: const Icon(
                Icons.border_color_outlined,
                size: 24.0,
              ),
              label: const Text(
                "Theme Color",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(left: 15),
                  alignment: Alignment.centerLeft),
              onPressed: () {
                chooseThemeColor(themeNotifier);
              },
            ),
            // Text size button
            TextButton.icon(
              icon: const Icon(
                Icons.format_size_sharp,
                size: 24.0,
              ),
              label: const Text(
                "Text Size",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(left: 15),
                  alignment: Alignment.centerLeft),
              onPressed: () {},
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 15,
              endIndent: 15,
            ),
            // Log out button
            TextButton.icon(
              icon: const Icon(
                Icons.logout,
                size: 24.0,
              ),
              label: const Text(
                "Log out",
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(left: 15),
                  alignment: Alignment.centerLeft),
              onPressed: () {},
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // Pop-up window
  chooseThemeColor(ThemeNotifier themeNotifier) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Choose Theme Color"),
            content: Container(
              width: 50,
              // Grid of color
              child: GridView.count(
                // Two element in one row
                crossAxisCount: 2,
                // Spacing between element
                childAspectRatio: 3 / 2,
                mainAxisSpacing: 30,
                padding: const EdgeInsets.only(top: 20),
                children: [
                  colorCircle(themeNotifier, Colors.pink, 'pink'),
                  colorCircle(themeNotifier, defaultColor, 'default'),
                  colorCircle(themeNotifier, Colors.orange, 'orange'),
                  colorCircle(themeNotifier, Colors.brown, 'brown'),
                  colorCircle(themeNotifier, Colors.lightBlue, 'lightBlue'),
                  colorCircle(themeNotifier, Colors.purple, 'purple'),
                ],
              ),
            ),
          );
        });
  }

  // Color circle button
  colorCircle(
      ThemeNotifier themeNotifier, MaterialColor color, String colorString) {
    return ElevatedButton(
      // Call setTheme method
      onPressed: () {
        themeNotifier.setThemeColor(
            ThemeData(primarySwatch: color), colorString);
      },
      // Color button shape
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: const CircleBorder(),
      ),
      child: null,
    );
  }
}
