import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hostels/components/RoundedInputField.dart';
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
  File? image;

  final nameController = TextEditingController();
  final locationController = TextEditingController();
  // final Image controller = ImageController(image: null,);
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  bool _isLoading = false;

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
            const SizedBox(
              height: 10,
            ),
            RoundedInputField(
              hintText: "Location of hostel",
              icon: Icons.location_off,
              field: locationController,
            ),
            const SizedBox(
              height: 20,
            ),
            RoundedInputField(
              hintText: "Description of hostel",
              icon: Icons.description,
              field: descriptionController,
            ),
            const SizedBox(
              height: 20,
            ),
            RoundedInputField(
              hintText: "Price of hostel",
              icon: Icons.attach_money,
              field: priceController,
              keyboard: TextInputType.number,
            ),
            if (image != null)  Image.file(
              image!,
              height: 200,
              width: 200,

            ),

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
                    icon: const Icon(Icons.add_photo_alternate_outlined),
                    iconSize: 28,
                    tooltip: "Attach Image of the item",
                    onPressed: startWebFilePicker,
                  ),
                  const SizedBox(
                    height: 5,
                  ),

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
            upload(),
          ],
        ),
      ),
    );
  }

  //upload logic

  void _addInfo() async {
    //storing key-value pairs
    Box<Content> hostelBox = Hive.box<Content>('hostelsBox');
    hostelBox.add(Content(nameController.text, locationController.text, descriptionController.text, priceController.text));
    Navigator.of(context).pop();

    print("Info added===================>rr");
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

  startWebFilePicker() async {
  try{
    final ImagePicker _picker = ImagePicker();
      // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image == null) return;
    final tempImage = File(image.path);
    print('------------------>$tempImage');
    setState(()=>this.image = tempImage);
  } on PlatformException catch (e) {
    print('Failed to pick image $e');
  }
  }
}


//  return ElevatedButton(
//       child: const Text("UPLOAD"),
    
//       onPressed: () {
//         if (nameController.text == ' ' || locationController.text == ' ') {
//           Flushbar(
//             message: "Empty field\s found!",
//             icon:
//                 const Icon(Icons.info_outline, size: 25.0, color: Colors.red),
//             duration: const Duration(seconds: 3),
//             leftBarIndicatorColor: Colors.red,
//           ).show(context);
//         } else {
//           // _addInfo();
//           Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(
//                   builder: (BuildContext context) => const Uploads()),
//               (route) => true);
//         }
//       },
//     );