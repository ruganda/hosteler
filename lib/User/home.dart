import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hostels/components/palette.dart';
import 'package:hostels/models/content.dart';
import 'package:hostels/user/booking.dart';

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
          "Hostels",
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
              color: Colors.white70),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Content>('hostelsBox').listenable(),
          builder: (context, Box box, _) {
            if (box.values.isEmpty) {
              return const Center(
                child: Text("Empty Hostel content"),
              );
            } else {
              return ListView.builder(
                  itemCount: box.values.length,
                  itemBuilder: (context, index) {
                    Content? currentContent = box.getAt(index);
                    return Container(
                      child: ListTile(
                        leading: const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage("assets/hostel.png"),
                        ),
                        title: Text("Hostel name: " + currentContent!.name),
                        subtitle:
                            Text("Hostel location: " + currentContent.location),
                        onLongPress: () {
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(
                                      "Do you want to Book at ${currentContent.name} ?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text("No")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          const Booking()),
                                                  (route) => true);
                                        },
                                        child: const Text("Yes"))
                                  ],
                                );
                              });
                        },
                      ),
                    );
                  });
            }
          }),
    );
  }
}
