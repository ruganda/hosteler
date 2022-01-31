import 'dart:ui';

import 'package:flutter/material.dart';

// import '../packages_exporter.dart';

// var color = color;
var color2 = Colors.blue[200];

class SignOutButton extends StatefulWidget {
  // final User user;

  // const SignOutButton({Key key}) : super(key: key);
  @override
  _SignOutButtonState createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<SignOutButton> {
  bool _isSigningOut = false;

  @override
  Widget build(BuildContext context) {
    // AppSizeConfig().init(context);
    var color = Theme.of(context).primaryColor;
    return !_isSigningOut
        ? Padding(
            padding: const EdgeInsets.all(2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  height: 4,
                  width: 30,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                TextButton.icon(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(color),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                  onPressed: dialog,
                  icon: Icon(
                    Icons.logout,
                    color: color2,
                  ),
                  label: Text(
                    'Sign Out',
                    style: TextStyle(
                      color: color2,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          );
  }

  void dialog() {
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        contentPadding: const EdgeInsets.all(15),
        backgroundColor: color2,
        elevation: 16.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        children: [
          Text(
            "displayName, do you want to Sign Out?",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w800,
                fontSize: 20),
          ),
          // ),
          // VerticalSpacing(of: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              dialogButton(
                buttonText: 'No',
                color: Theme.of(context).primaryColor,
                textColor: Colors.black45,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 10),
              dialogButton(
                buttonText: 'Yes',
                color: Colors.redAccent[700],
                textColor: Colors.white,
                onTap: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget dialogButton({
  VoidCallback? onTap,
  Color? color,
  Color? textColor,
  String? buttonText,
}) {
  return TextButton(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      backgroundColor: MaterialStateProperty.all(color),
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    ),
    onPressed: onTap,
    // icon: Icon(
    //   Icons.logout,
    //   color: color2,
    // ),
    child: Text(
      buttonText!,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}
