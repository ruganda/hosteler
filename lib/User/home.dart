import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hostels/components/palette.dart';
import 'package:hostels/models/content.dart';
import 'package:hostels/user/booking.dart';
import 'package:hostels/user/map_page.dart';
import 'package:text_to_speech/text_to_speech.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextToSpeech tts = TextToSpeech();

  Home() {
    tts.setLanguage('en');
    tts.setRate(0.4);
    tts.setVolume(0.8);
  }

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
                        leading: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: Image.file(
                              File(currentContent!.image),
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text("Hostel name: " + currentContent.name),
                        subtitle:
                            Text("Hostel location: " + currentContent.location),
                        onTap: () {
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
                        trailing: IconButton(
                          onPressed: () {
                            tts.speak(currentContent.name);
                            // tts.speak(currentContent.location);
                          },
                          color: Colors.black,
                          icon: const Icon(Icons.speaker_phone),
                        ),
                        onLongPress: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const MapsPage()),
                              (route) => true);
                        },
                      ),
                    );
                  });
            }
          }),
    );
  }
}
