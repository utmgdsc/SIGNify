import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  var txt = TextEditingController();

  Widget build(BuildContext build) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          title: const Text(
            "Log In",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
            child: Column(children: [
              Form(
                key: formkey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: <Widget>[
                        title("Email"),
                      ],
                    ),
                    emailField(),
                    Container(
                      margin: EdgeInsets.only(bottom: 40),
                    ),
                    Row(
                      children: <Widget>[
                        title("Password"),
                      ],
                    ),
                    passwordField(),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    Row(
                      children: const <Widget>[
                        Text(
                          'Forgot your password?',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                    ),
                    const SizedBox(
                      height: 150,
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
                              onPressed: () {},
                              color: Color(0xff108A7E),
                              child: const Text(
                                "LOG IN",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )))
                  ],
                ),
              ),
            ]),
          ),
        ));
  }

  Widget title(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
    );
  }
}
