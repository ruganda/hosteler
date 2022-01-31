import 'package:flutter/material.dart';

// import '../packages_exporter.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
        image: DecorationImage(
          image: CachedNetworkImageProvider(
              "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfDF8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60"),
          fit: BoxFit.cover,
        ),
        border: Border.all(color: color.withOpacity(0.8), width: 4),
        color: color.withOpacity(0.4),
      ),
      // child: user.photoURL == null
      //     ? Icon(
      //         Icons.person,
      //         size: getProportionateScreenWidth(80),
      //         color: Colors.orangeAccent[100],
      //       )
      //     : SizedBox(),
    );
  }
}
