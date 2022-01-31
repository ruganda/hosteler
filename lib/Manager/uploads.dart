import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hostel_booking/components/palette.dart';
import 'package:hostel_booking/models/content.dart';

class Uploads extends StatefulWidget {
  const Uploads({Key? key}) : super(key: key);

  @override
  State<Uploads> createState() => _UploadsState();
}

class _UploadsState extends State<Uploads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fontsColor,
        title: const Text(
          "Uploaded Hostels",
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
              color: Colors.white70),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box('hostelsBox').listenable(),
          builder: (context, Box box, _) {
            if (box.values.isEmpty) {
              return const Center(
                child: Text("Empty Hostel content"),
              );
            } else {
              return ListView.builder(
                  itemCount: box.values.length,
                  itemBuilder: (context, index) {
                    Content currentContent = box.getAt(index);
                    return Container(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.amberAccent[100],
                        ),           
                        title: Text(currentContent.name),
                        subtitle: Text(currentContent.location),
                        trailing: IconButton(
                            onPressed: () async {
                              await box.deleteAt(index);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
