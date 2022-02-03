import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Custom Green for app
Map<int, Color> primary =
{
  50:Color.fromRGBO(17,138,126, .1),
  100:Color.fromRGBO(17,138,126, .2),
  200:Color.fromRGBO(17,138,126, .3),
  300:Color.fromRGBO(17,138,126, .4),
  400:Color.fromRGBO(17,138,126, .5),
  500:Color.fromRGBO(17,138,126, .6),
  600:Color.fromRGBO(17,138,126, .7),
  700:Color.fromRGBO(17,138,126, .8),
  800:Color.fromRGBO(17,138,126, .9),
  900:Color.fromRGBO(17,138,126, 1),
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

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
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '0',//'$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => const MySettingsPage(title: 'Settings')
              )
            );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.settings),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MySettingsPage extends StatefulWidget {
  const MySettingsPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

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
        title: Text(widget.title),
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
