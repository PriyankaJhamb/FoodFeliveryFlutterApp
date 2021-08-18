import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({Key? key}) : super(key: key);

  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {

  String imagePath = "NA";
  String userPhone = "9999911111";
  final ImagePicker _picker = ImagePicker();

  Future<void> uploadFile(String filePath) async {
    File file = File(filePath);

    try {
      await FirebaseStorage.instance
          .ref('profile-pics/'+userPhone+'.png')
          .putFile(file);
      print("UPLOAD SUCCESS");
    } on FirebaseException catch (e) {
      print("UPLOAD FAILED");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(imagePath),
            SizedBox(
              height: 10,
            ),
            OutlinedButton(onPressed: () async {
              final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

              /*setState(() {
                imagePath = image!.path;
              });*/
              uploadFile(image!.path);

            }, child: Text("SELECT IMAGE"))
          ],
        ),
      ),
    );
  }
}