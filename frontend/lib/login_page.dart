import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'camera_screen.dart';
import 'user_info.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Widget build(BuildContext context) {
    // Create userInfo variable to access user_info class method
    final userInfo = Provider.of<UserInfo>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          title: const Text(
            "Log In",
            // style: TextStyle(
            //   color: Colors.black,
            //   fontSize: 20,
            //   fontWeight: FontWeight.bold,
            // ),
          ),
          // backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              // color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
            child: Column(children: [
              Form(
                key: formkey,
                child: Column(
                  children: <Widget>[

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
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom != 0
                          ? 20
                          : MediaQuery.of(context).size.height * 0.40,
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
                                  login(email.text, password.text, userInfo);
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
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget emailField(TextEditingController email) {
    return TextFormField(
      controller: email,
      decoration: const InputDecoration(
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
      decoration: const InputDecoration(
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

  login(String emailText, String passwordText, UserInfo userInfo) async {
    // parse URL
    var url = Uri.parse('https://signify-10529.uc.r.appspot.com/login');
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
    String userId = jsonDecode(response.body)['id'];

    if (userId.isNotEmpty) {
      // store user id
      userInfo.setUserId(userId);
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
