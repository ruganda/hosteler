import 'dart:html';
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hostel_booking/Manager/uploads.dart';
import 'package:hostel_booking/components/RoundedInputField.dart';
import 'package:hostel_booking/components/palette.dart';
import 'package:hostel_booking/models/content.dart';

class PageUpload extends StatefulWidget {
  PageUpload({Key? key}) : super(key: key);

  @override
  State<PageUpload> createState() => _PageUploadState();
}

class _PageUploadState extends State<PageUpload> {
  late final Box box;
  @override
  void initState() {
    super.initState();
    //get reference to an already opened box
    box = Hive.box('hostelsBox');
  }

  @override
  void dispose() {
    //close all hive boxes
    Hive.close();
    super.dispose();
  }

  final nameController = TextEditingController();
  final locationController = TextEditingController();

  // variable to hold image to be displayed

  late List<int> _selectedFile;
  late Uint8List _bytesData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fontsColor,
        title: const Text(
          "Upload hostel",
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w800,
              color: Colors.white70),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          RoundedInputField(
            hintText: "Name of hostel",
            icon: Icons.house,
            field: nameController,
          ),
          const SizedBox(
            height: 20,
          ),
          //image space
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black87),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.upload_file),
                    iconSize: 28,
                    tooltip: "Attach Image of the item",
                    onPressed: startWebFilePicker,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // if (_selectedFile != null)
                  //   kIsWeb
                  //        Image.memory(
                  //           _selectedFile,
                  //           fit: BoxFit.fitHeight,
                  //           height: 250,
                  //           width: 200,
                  //         )
                  //       : Image.memory(
                  //           _selectedFile,
                  //           fit: BoxFit.fitHeight,
                  //           height: 250,
                  //           width: 200,
                  //         ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          RoundedInputField(
            hintText: "Location of hostel",
            icon: Icons.house,
            field: locationController,
          ),
          const SizedBox(
            height: 20,
          ),
          upload(),
        ],
      ),
    );
  }

  // method for selecting image
  startWebFilePicker() async {
    html.InputElement? uploadInput =
        html.FileUploadInputElement() as InputElement?;
    uploadInput!.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = new html.FileReader();

      reader.onLoadEnd.listen((e) {
        _handleResult(reader.result);
      });
      reader.readAsDataUrl(file);
    });
  }

  void _handleResult(result) {
    setState(() {
      _bytesData =
          const Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
    });
  }

  //upload logic

  void _addInfo() async {
    //storing key-value pairs
    Box hostelBox = Hive.box('hostelsBox');
    hostelBox.add(Content(nameController.text, locationController.text));

    print("Info added");
  }

  upload() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(29)),
      child: ElevatedButton(
        child: const Text("UPLOAD"),
        style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40)),
        onPressed: () {
          if (nameController == " " || locationController == " ") {
            Flushbar(
              message: "Empty field/s found!",
              icon:
                  const Icon(Icons.info_outline, size: 25.0, color: Colors.red),
              duration: const Duration(seconds: 3),
              leftBarIndicatorColor: Colors.red,
            ).show(context);
          } else {
            _addInfo();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => const Uploads()),
                (route) => true);
          }
        },
      ),
    );
  }
}
