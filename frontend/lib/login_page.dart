import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'camera_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

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
                    emailField(email),
                    Container(
                      margin: EdgeInsets.only(bottom: 40),
                    ),
                    Row(
                      children: <Widget>[
                        title("Password"),
                      ],
                    ),
                    passwordField(password),
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
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  login(email.text, password.text);
                                }
                              },
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

  Widget emailField(TextEditingController email) {
    return TextFormField(
      controller: email,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      validator: (value) {
        // check email empty
        if (value == null || value.isEmpty) {
          return ('Please enter an email');
          // check email format
        } else if (!EmailValidator.validate(value)) {
          return ('Please enter a valid email');
        }
        return null;
      },
    );
  }

  Widget passwordField(TextEditingController password) {
    return TextFormField(
      obscureText: true,
      controller: password,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return ('Please enter a password');
        }
        return null;
      },
    );
  }

  login(String emailText, String passwordText) async {
    // parse URL
    var url = Uri.parse('http://10.0.2.2:5000/login');
    // http post request to backend Flask
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'email': emailText, 'password': passwordText}),
    );
    // parse json and retrieve the result
    bool result = jsonDecode(response.body)['result'];

    if (result) {
      // login successes and navigate to camera page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CameraScreen()),
      );
    } else {
      // login failed and show error message
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text(
                'Incorrect password',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0))),
            );
          });
    }
  }
}
