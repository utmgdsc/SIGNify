import 'package:flutter/material.dart';
import 'package:frontend/create_account.dart';
import 'package:frontend/login_page.dart';
import 'package:frontend/camera_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  Widget build(BuildContext build) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xffADD7D3), Colors.white])),
      child: Container(
        margin: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 10,
            top: MediaQuery.of(context).size.height * 0.25),
        child: Column(children: [
          Container(
              height: 250,
              width: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage("assets/images/logo.png"),
                ),
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                      width: 350,
                      height: 54,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CreateAccount()));
                        },
                        color: Color(0xff108A7E),
                        child: const Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ))),
              const SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                      width: 350,
                      height: 54,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginPage()));
                        },
                        color: Colors.white,
                        child: const Text(
                          "LOG IN",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ))),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CameraScreen()));
                },
                child: const Text(
                  'Continue As Guest',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationThickness: 2,
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    ));
  }
}
