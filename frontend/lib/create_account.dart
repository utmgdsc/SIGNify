import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccount createState() => _CreateAccount();
}

class _CreateAccount extends State<CreateAccount> {
  final formkey = GlobalKey<FormState>();
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
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          title: const Text(
            "Create Account",
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
                        title("What is your email?"),
                      ],
                    ),
                    emailField(),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const <Widget>[
                        Text(
                          "You will need to confirm this email later",
                        ),
                      ],
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
                                if (formkey.currentState!.validate()) {}
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
}
