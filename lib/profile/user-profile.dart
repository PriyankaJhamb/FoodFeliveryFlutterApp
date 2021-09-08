import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/custom-widgets/ShowSnackBar.dart';
import 'package:fooddelivery/util/constants.dart';
import 'package:image_picker/image_picker.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  String imageUrl = "";

  //update user profile
  void UpdateUser(BuildContext context) {
    print(Util.appUser!.uid);
    print(Util. appUser!.imageUrl);
    FirebaseFirestore.instance
        .collection("users")
        .doc(Util. appUser!.uid)
        .update({"imageUrl": Util. appUser!.imageUrl. toString()});
    // then((value) => Navigator.pushReplacementNamed(context, "/home"));
  }

  //ImagePicker

  imageName(){
    return Util.appUser!.uid;
  }
  String imagePath = "";
  final ImagePicker _picker = ImagePicker();

  Future<void> uploadFile(String filePath) async {
    File file = File(filePath);
    try {
      Show_Snackbar(context: context, message: "Uploading");
      var pickUpload= await FirebaseStorage.instance
          .ref('profile-pics/' + imageName() + '.png')
          .putFile(file);

      var dowurl = await(pickUpload).ref.getDownloadURL();
      print(dowurl);
      Util. appUser!.imageUrl = dowurl.toString();
      imageUrl = dowurl.toString();
      Show_Snackbar(context: context, message: "Uploaded");
      print("UPLOAD SUCCESS");
      print(Util. appUser!.imageUrl. toString());

      setState(() {
        UpdateUser(context);
      });
    } on FirebaseException catch (e) {
      Show_Snackbar(context: context, message: "Upload Failed");
      print("UPLOAD FAILED");
    }
  }

  //Dialog Box

  Future<void> _askedToLead() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 5), () {
            Navigator.of(context).pop(true);
          });
          return SimpleDialog(
            title: const Text('Select option'),
            children: <Widget>[
              SimpleDialogOption(
                  onPressed: () async {
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.camera);
                    uploadFile(image!.path);
                  },
                  child: Text('Camera'),
                  padding: EdgeInsets.all(20)),
              SimpleDialogOption(
                  onPressed: () async {
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    uploadFile(image!.path);

                  },
                  child: Text('Gallery'),
                  padding: EdgeInsets.all(20)),
            ],
          );
        });
  }

  // Future fetchUserDetails() async {
  //   print("hello");
  //   String uid = await FirebaseAuth.instance.currentUser!.uid.toString();
  //   var document = await FirebaseFirestore.instance
  //       .collection(Util.USERS_COLLECTION)
  //       .doc(uid)
  //       .get();
  //   // appUser =AppUser();
  //   // print("Hello $document.get['uid'].toString()");
  //   // appUser!.uid = document.get('uid').toString();
  //   // appUser!.name = document.get('name').toString();
  //   // appUser!.email = document.get('email').toString();
  //   // appUser!.imageUrl = document.get('imageUrl').toString();
  //   // image=appUser!.imageUrl!;
  //
  //   if (document.exists) {
  //     appUser = AppUser();
  //     print("Hello $document.get['uid'].toString()");
  //     appUser!.uid = document.get('uid').toString();
  //     appUser!.name = document.get('name').toString();
  //     appUser!.email = document.get('email').toString();
  //     appUser!.imageUrl = document.get('imageUrl').toString();
  //     imageName=document.get('email').toString();
  //     imageUrl=appUser!.imageUrl!;
  //   } else {
  //     print("error");
  //   }
  //   return appUser;
  // }

  @override
  Widget build(BuildContext context) {
    imageUrl = Util.appUser!.imageUrl!;
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Card(
          elevation: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.all(8)),
              InkWell(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  radius: 100,
                ),
                onTap: () {
                  _askedToLead();
                  //image picker logic
                },
              ),
              Padding(
                padding: EdgeInsets.all(8),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                Util. appUser!.name.toString(),
                style: TextStyle(color: Colors.blueGrey, fontSize: 20),
              ),
              Text(
                Util. appUser!.email.toString(),
                style: TextStyle(color: Colors.black38, fontSize: 15),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
        SizedBox(
          height: 40,
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text(
            "Manage Profile",
          ),
          subtitle: Text("Update Your Data for Your Account"),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text(
            "Manage Orders",
          ),
          subtitle: Text("Manage your Order History here"),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text(
            "Manage Addresses",
          ),
          subtitle: Text("Update Your Addresses for Delivery"),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () {
            Util.checkpath=false;
            Navigator.pushNamed(context, "/useraddresses");
          },
        ),
        ListTile(
          leading: Icon(Icons.message),
          title: Text(
            "Help",
          ),
          subtitle: Text("Raise your Queries"),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.document_scanner_outlined),
          title: Text(
            "Terms & Conditions",
          ),
          subtitle: Text("Check our Terms and Conditions"),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: () {},
        ),
      ],
    );
  }
}
