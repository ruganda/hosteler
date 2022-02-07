import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hostels/components/RoundedInputField.dart';
import 'package:hostels/components/RoundedPasswordField.dart';
import 'package:hostels/components/TabLabel.dart';
import 'package:hostels/components/palette.dart';
import 'package:hostels/manager/01_login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passController = new TextEditingController();
  final TextEditingController passConfController = new TextEditingController();

  bool _isLoading = false;
  bool _shPassword = true;
  bool _shConfirmPass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                const Text(
                  "Manager Registration",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.8,
                      color: Colors.white),
                ),
                const SizedBox(height: 5.0),
                const TabLabel(
                  label: 'Registration Form',
                  color: kappSecondary,
                ),
                const SizedBox(height: 10.0),
                const SizedBox(height: 10.0),
                sectionB(),
                const SizedBox(height: 10.0),
                sectionC(),
                const SizedBox(height: 10.0),
                registerButton(),
              ],
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: InkWell(
                child: const Text(
                  "LOGIN",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) => Login(),
                      ),
                      (Route<dynamic> route) => false);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //UI Components

  sectionB() {
    return Column(
      children: [
        RoundedInputField(
          hintText: "Email Address",
          field: emailController,
          fcolor: Colors.white70,
          icon: Icons.mail_outline,
          onChanged: (value) {},
        ),
      ],
    );
  }

  sectionC() {
    return Column(
      children: [
        RoundedPasswordField(
          passwordhint: 'Password',
          field: passController,
          fcolor: Colors.white70,
          hideText: _shPassword,
          showHide: () {
            setState(() {
              _shPassword = !_shPassword;
            });
          },
        ),
        RoundedPasswordField(
          passwordhint: 'Confirm Password',
          field: passConfController,
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
  registerButton() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(kappSecondary),
        ),
      );
    } else {
      return ElevatedButton(
        child: const Text("SIGNUP"),
        onPressed: () {
          if (emailController.text == '' ||
              passController.text == '' ||
              passConfController.text == '') {
            Flushbar(
              message: "Empty field\s found!",
              icon:
                  const Icon(Icons.info_outline, size: 25.0, color: Colors.red),
              duration: const Duration(seconds: 3),
              leftBarIndicatorColor: Colors.red,
            )..show(context);
          } else {
            //phoneno check + email check missing
            if (passController.text != passConfController.text) {
              Flushbar(
                message: "Passwords do not match",
                icon: const Icon(Icons.info_outline,
                    size: 25.0, color: Colors.red),
                duration: const Duration(seconds: 3),
                leftBarIndicatorColor: Colors.red,
              )..show(context);
            } else {
              setState(() {
                _isLoading = true;
              });
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) => Login(),
                  ),
                  (Route<dynamic> route) => false);
            }
          }
        },
      );
    }
  }
}
