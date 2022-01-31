import 'package:flutter/material.dart';
import 'package:hostel_booking/User/home.dart';
import 'package:hostel_booking/User/profile/user_profile.dart';
import 'package:hostel_booking/components/palette.dart';
import 'package:hostel_booking/components/bottombar_item.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int activeTab = 0;
  List<IconData> tapIcons = [Icons.home_filled, Icons.person_rounded];
  List<Widget> pages = [
    Home(),
    UserInfoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return goHome();
  }

  goHome() {
    return Scaffold(
        backgroundColor: appBgColor,
        bottomNavigationBar: getBottomBar(),
        body: getBarPage());
  }

  Widget getBottomBar() {
    return Container(
      height: 75,
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: bottomBarColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: shadowColor.withOpacity(0.1),
                blurRadius: .5,
                spreadRadius: .5,
                offset: const Offset(0, 1))
          ]),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
              tapIcons.length,
              (index) => BottomBarItem(
                    tapIcons[index],
                    "",
                    isActive: activeTab == index,
                    activeColor: primary,
                    onTap: () {
                      setState(() {
                        activeTab = index;
                      });
                    },
                  ))),
    );
  }

  Widget getBarPage() {
    return IndexedStack(
        index: activeTab,
        children: List.generate(tapIcons.length, (index) => pages[index]));
  }
}
