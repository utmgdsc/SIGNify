import 'package:flutter/material.dart';

class MySettingsPage extends StatefulWidget {
  const MySettingsPage({Key? key}) : super(key: key);

  @override
  State<MySettingsPage> createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Settings"),
      ),
      body: Column(
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          const SizedBox(height: 50,),
          Row(
            children: const <Widget> [
              SizedBox(width: 15,),
              Icon(
                Icons.access_time,
                size: 24.0,
              ),
              SizedBox(width: 5,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "History",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              ],
          ),
          const SizedBox(height: 20,),
          Row(
            children: const <Widget> [
              SizedBox(width: 15,),
              Icon(
                Icons.mode_night_outlined,
                size: 24.0
              ),
              SizedBox(width: 5,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Dark/Light Mode",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              ],
          ),
          const SizedBox(height: 20,),
          Row(
            children: const <Widget> [
              SizedBox(width: 15,),
              Icon(
                Icons.border_color_outlined,
                size: 24.0,
              ),
              SizedBox(width: 5,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Theme Color",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              ],
          ),
          const SizedBox(height: 20,),
          Row(
            children: const <Widget> [
              SizedBox(width: 15,),
              Icon(
                Icons.format_size_sharp,
                size: 24.0,
              ),
              SizedBox(width: 5,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Text Size",
                  style: TextStyle(fontWeight: FontWeight.w900),
                  
                ),
              ),
              ],
          ),
          const SizedBox(height: 10,),
          const Divider(
            color: Colors.grey,
            indent: 15,
            endIndent: 15,
          ),
          const SizedBox(height: 10,),
          Row(
            children: const <Widget> [
              SizedBox(width: 15,),
              Icon(
                Icons.logout,
                color: Colors.teal,
                size: 24.0,
              ),
              SizedBox(width: 5,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Log out",
                  style: TextStyle(fontWeight: FontWeight.w900, color: Colors.teal),
                ),
              ),
              ],
          ),
        ]
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
