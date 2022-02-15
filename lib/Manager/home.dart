import 'package:flutter/material.dart';
import 'package:hostels/components/palette.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:hostels/manager/upload_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fontsColor,
        title: const Text(
          "Hostels Manager",
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
              color: Colors.white70),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: AvatarGlow(
                startDelay: const Duration(milliseconds: 10),
                glowColor: fontsColor,
                endRadius: 200.0,
                duration: const Duration(milliseconds: 2000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: const Duration(microseconds: 100),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => PageUpload()),
                        (route) => true);
                  },
                  elevation: 20.0,
                  shape: const CircleBorder(),
                  child: Container(
                    width: 200,
                    height: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: fontsColor,
                        borderRadius: BorderRadius.circular(140)),
                    child: const Text(
                      "Click to Upload",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w800,
                          color: Colors.white70),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}//end
