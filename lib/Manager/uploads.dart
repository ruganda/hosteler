
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hostels/components/palette.dart';
import 'package:hostels/models/content.dart';

class Uploads extends StatefulWidget {
  const Uploads({Key? key}) : super(key: key);

  @override
  _UploadsState createState() => _UploadsState();
}

class _UploadsState extends State<Uploads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fontsColor,
        title: const Text(
          "My Hostels",
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
              color: Colors.white70),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Content>('hostelsBox').listenable(),
          builder: (context, Box<Content> box, _) {
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
                          backgroundImage: AssetImage("assets/hostel.png"),
                          radius: 50,
                        ),
                        title: Text(currentContent!.name),
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
