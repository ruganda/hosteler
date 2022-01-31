import 'package:flutter/material.dart';

// import '../packages_exporter.dart';
import 'user_profile_body.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserInfoScreen extends StatelessWidget {
  // final User user;
  // const UserInfoScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AppSizeConfig().init(context);
    var color = Theme.of(context).primaryColor;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: color,
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfDF8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color,
                  color.withOpacity(0.5),
                  color.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          ///Body
          UserProfileBody(),
        ],
      ),
    );
  }
}
