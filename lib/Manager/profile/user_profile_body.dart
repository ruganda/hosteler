import 'package:flutter/material.dart';

// import '../packages_exporter.dart';
import 'profile_pic.dart';
// import 'sign_out_button.dart';
import 'package:hostel_booking/Manager/profile/TabButton.dart';
import 'package:hostel_booking/Manager/profile/TabLabel.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileBody extends StatefulWidget {
  @override
  _UserProfileBodyState createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends State<UserProfileBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: ProfilePic(),
          ),
          const Center(
            child: Text(
              "Ngela Yu",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 30,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                "manager@email.com",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                "+256 778 456783",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          // Spacer(flex: 2),
          // SignOutButton(),
          const SizedBox(height: 5.0),
          const TabLabel(
              label: 'Get Help',
              color: Colors.white,
              align: Alignment.centerLeft),
          const SizedBox(height: 10.0),
          TabButton(
            label: "Call Help Line",
            icon: Icons.phone_forwarded_outlined,
            page: () {
              launch("tel:+256789530574");
            },
          ),
          TabButton(
            label: "Report a problem",
            icon: Icons.mail,
            page: () {
              launch(
                  "mailto:arnoldrutanana@gmail.com.com?subject=Report%20Problem");
            },
          ),
          TabButton(
            label: 'Send Feedback',
            icon: Icons.feedback_outlined,
            page: () {
              launch(
                  "mailto:arnoldrutanana@gmail.com.com?subject=Report%20Problem");
            },
          ),
          const TabLabel(
            label: 'More',
            color: Colors.white,
            align: Alignment.centerLeft,
          ),
          const SizedBox(height: 10.0),
          ListButton(
            label: 'About',
            icon: Icons.help_outline,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
