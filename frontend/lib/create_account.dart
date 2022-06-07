import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:frontend/user_info.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'camera_screen.dart';
import 'login_page.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccount createState() => _CreateAccount();
}

class _CreateAccount extends State<CreateAccount> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController confirm = TextEditingController();
  bool _passwordVisibleFirst = false;
  bool _passwordVisibleConfirm = false;

  @override
  void initState() {
    _passwordVisibleFirst = false;
    _passwordVisibleConfirm = false;
  }

  Widget build(BuildContext build) {
    // Create userInfo variable to access user_info class method
    final userInfo = Provider.of<UserInfo>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          title: const Text(
            "Create Account",
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
                    Row(
                      children: <Widget>[
                        title("What is your email?"),
                      ],
                    ),
                    emailField(email),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    Row(
                      children: <Widget>[
                        title("Create a password"),
                      ],
                    ),
                    passwordFieldFirst(pass),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const <Widget>[
                        Text(
                          "Use at least 8 characters",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    Row(
                      children: <Widget>[
                        title("Confirm password"),
                      ],
                    ),
                    passwordFieldConfirm(confirm),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const <Widget>[
                        Text(
                          "Use at least 8 characters",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom != 0
                          ? 20
                          : MediaQuery.of(context).size.height * 0.30,
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
                                  createAccount(
                                      email.text, pass.text, userInfo);
                                }
                              },
                              color: Color(0xff108A7E),
                              child: const Text(
                                "Create Account",
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

  Widget passwordFieldFirst(TextEditingController pass) {
    return TextFormField(
      obscureText: !_passwordVisibleFirst,
      controller: pass,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _passwordVisibleFirst ? Icons.visibility : Icons.visibility_off,
            color: Color(0xff108A7E),
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _passwordVisibleFirst = !_passwordVisibleFirst;
            });
          },
        ),
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return ('Please enter a password');
        } else if (value.length < 8) {
          return ('Password must be 8 characters');
        }
        return null;
      },
    );
  }

  Widget passwordFieldConfirm(TextEditingController confirm) {
    return TextFormField(
      obscureText: !_passwordVisibleConfirm,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _passwordVisibleConfirm ? Icons.visibility : Icons.visibility_off,
            color: Color(0xff108A7E),
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _passwordVisibleConfirm = !_passwordVisibleConfirm;
            });
          },
        ),
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return ('Please enter a password');
        } else if (value.length < 8) {
          return ('Password must be 8 characters');
        }
        if (value != pass.text) {
          return ('Passwords do not match');
        }
        return null;
      },
    );
  }

  createAccount(
      String emailText, String passwordText, UserInfo userInfo) async {
    // parse URL
    var url = Uri.parse('https://signify-10529.uc.r.appspot.com/register');
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
      // register successes and navigate to login page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CameraScreen()),
      );
    } else {
      // register failed and show error message
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text(
                'Email already exist',
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
