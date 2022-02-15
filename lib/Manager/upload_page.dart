import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hostels/components/RoundedInputField.dart';
import 'package:hostels/components/location_utilities.dart';
import 'package:hostels/components/palette.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:hostels/manager/uploads.dart';
import 'package:hostels/models/content.dart';
import 'package:image_picker/image_picker.dart';

class PageUpload extends StatefulWidget {
  const PageUpload({Key? key}) : super(key: key);

  @override
  _PageUploadState createState() => _PageUploadState();
}

class _PageUploadState extends State<PageUpload> {
  late final Box box;

  final nameController = TextEditingController();
  final locationpickerController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  //automatic location picker
  final locationController = TextEditingController();
  final _gpsDetailsController = TextEditingController();

  double? _latitude;
  double? _longitude;
  double? _accuracy;
  double? _altitude;
  double? _speedAccuracy;
  bool _showLoad = false;
  bool _loadingLocation = false;
  bool _readOnly = false;

  bool _isLoading = false;

  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

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
      body: Center(
        child: ListView(
          children: [
            RoundedInputField(
              hintText: "Name of hostel",
              icon: Icons.nature,
              field: nameController,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                children: [
                  IconButton(
                    onPressed: getImage,
                    icon: const Icon(Icons.camera),
                  ),
                  Center(
                    child: _image == null
                        ? const Text('No image selected.')
                        : Image.file(
                            _image!,
                            height: 300,
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            RoundedInputField(
              hintText: "Location of hostel",
              icon: Icons.location_off,
              field: locationpickerController,
            ),
            const SizedBox(
              height: 10,
            ),
            RoundedInputField(
              hintText: "Location Picker",
              field: locationController,
              icon: Icons.gps_fixed_rounded,
              onChanged: (value) {},
              tap: () {
                setState(() {
                  if (_latitude != null && _longitude != null) {
                    _loadingLocation = false;
                    locationController.text =
                        "POINT(" + "$_latitude $_longitude" + ")";
                  } else {
                    _showLoad = true;
                    _loadingLocation = true;
                    getLocationCoordinates();
                    locationController.text = "Please wait";
                    _gpsDetailsController.text = "Loading...";
                  }
                });
              },
            ),
            RoundedInputField(
              hintText: "Description of hostel",
              icon: Icons.description,
              field: descriptionController,
            ),
            const SizedBox(
              height: 10,
            ),
            RoundedInputField(
              hintText: "Price of hostel room",
              icon: Icons.price_change,
              field: priceController,
            ),
            const SizedBox(
              height: 5,
            ),
            upload(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  getLocationCoordinates() async {
    try {
      _latitude = (await Utils().locationCoordinates())!.latitude!;
      _longitude = (await Utils().locationCoordinates())!.longitude!;
      _accuracy = (await Utils().locationCoordinates())!.accuracy!;
      _altitude = (await Utils().locationCoordinates())!.altitude!;
      _speedAccuracy = (await Utils().locationCoordinates())!.speedAccuracy!;

      locationController.text = "Latitude: $_latitude\n"
          "Longitude: $_longitude\n"
          "Accuracy: $_accuracy\n"
          "Altitude: $_altitude\n"
          "Speed Accuracy: $_speedAccuracy";
      locationController.text = "POINT(" + "$_latitude $_longitude" + ")";
      _showLoad = false;
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  //upload l
  String imageURL = '';
  void _addInfo() {
    //storing key-value pairs
    Box<Content> hostelBox = Hive.box<Content>('hostelsBox');
    hostelBox.add(Content(
      nameController.text,
      locationpickerController.text,
      _image!.path,
      // locationController.text,
      // descriptionController.text,
      // priceController.text
    ));
    Navigator.of(context).pop();

    print("Info added");
  }

  upload() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(kappSecondary),
        ),
      );
    } else {
      return ElevatedButton(
        child: const Text("Add hostels"),
        onPressed: () {
          if (nameController.text == ' ' || locationController.text == ' ') {
            Flushbar(
              message: "Empty field\s found!",
              icon:
                  const Icon(Icons.info_outline, size: 25.0, color: Colors.red),
              duration: const Duration(seconds: 3),
              leftBarIndicatorColor: Colors.red,
            ).show(context);
          } else {
            setState(() {
              _isLoading = true;
            });
            _addInfo();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) => const Uploads(),
                ),
                (Route<dynamic> route) => true);
          }
        },
      );
    }
  }
}
