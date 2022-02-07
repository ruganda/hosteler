import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hostels/components/RoundedInputField.dart';
import 'package:hostels/components/RoundedPasswordField.dart';
import 'package:hostels/components/palette.dart';
import 'package:hostels/manager/02_register.dart';
import 'package:hostels/manager/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  bool _shConfirmPass = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 70.0),
            const Text(
              "Manager Login",
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.8,
                  color: Colors.white),
            ),
            headerSection(),
            inputSection(),
            loginButton(),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: InkWell(
                  child: const Text(
                    "REGISTER",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) => Register(),
                        ),
                        (Route<dynamic> route) => false);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //UI Components
  headerSection() {
    return Container(
      height: 300.0,
      child: const Center(
        child: Icon(
          Icons.location_on_outlined,
          color: Colors.white,
          size: 150.0,
        ),
      ),
    );
  }

  inputSection() {
    return Column(
      children: [
        RoundedInputField(
          hintText: "Email Address",
          icon: Icons.mail_outline,
          field: emailController,
          fcolor: Colors.white70,
          onChanged: (value) {},
        ),
        RoundedPasswordField(
          passwordhint: 'Password',
          field: passwordController,
          fcolor: Colors.white70,
          hideText: _shConfirmPass,
          showHide: () {
            setState(() {
              _shConfirmPass = !_shConfirmPass;
            });
          },
        ),
      ],
    );
  }

  //LogicTrigger
  loginButton() {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation(kappSecondary),
            ),
          )
        : ElevatedButton(
            child: const Text("SIGN IN"),
            onPressed: () async {
              if (emailController.text == ' ' ||
                  passwordController.text == ' ') {
                Flushbar(
                  message: "Empty field\s found!",
                  icon: const Icon(Icons.info_outline,
                      size: 25.0, color: Colors.red),
                  duration: const Duration(seconds: 3),
                  leftBarIndicatorColor: Colors.red,
                ).show(context);
              } else {
                setState(() {
                  _isLoading = true;
                });
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                var x =
                    sharedPreferences.setString("email", emailController.text);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Index(),
                    ),
                    (Route<dynamic> route) => true);
                print(x);
              }
            },
          );
  }
}
