import 'package:flutter/material.dart';

// import '../packages_exporter.dart';

class ProfilePic extends StatelessWidget {
  // final User user;

  // const ProfilePic({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // AppSizeConfig().init(context);
    var color = Colors.white;
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: const DecorationImage(
          image: AssetImage("assets/manager.png"),
          fit: BoxFit.cover,
        ),
        border: Border.all(color: color.withOpacity(0.8), width: 4),
        color: color.withOpacity(0.4),
      ),
    );
  }
}
