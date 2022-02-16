import 'package:flutter/material.dart';
import 'package:hostels/components/palette.dart';

// import '../packages_exporter.dart';
import 'user_profile_body.dart';

class UserInfoScreen extends StatelessWidget {
  // final User user;
  // const UserInfoScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AppSizeConfig().init(context);
    var color = Theme.of(context).primaryColor;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: fontsColor,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: AssetImage("assets/manager.png"),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: color.withOpacity(0.8), width: 4),
              color: color.withOpacity(0.4),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  fontsColor,
                  color.withOpacity(0.5),
                  color.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          ///Body
          const UserProfileBody(),
        ],
      ),
    );
  }
}
