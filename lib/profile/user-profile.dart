import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/model/user.dart';
import 'package:fooddelivery/util/constants.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  AppUser? appUser;
  Future fetchUserDetails() async {
    print("hello");
    String uid = await FirebaseAuth.instance.currentUser!.uid.toString();
    var document = await FirebaseFirestore.instance.collection(
        USERS_COLLECTION).doc(uid).get();
    // appUser =AppUser();
    // print("Hello $document.get['uid'].toString()");
    // appUser!.uid = document.get('uid').toString();
    // appUser!.name = document.get('name').toString();
    // appUser!.email = document.get('email').toString();
    // appUser!.imageUrl = document.get('imageUrl').toString();

    if (document.exists)
      {

        appUser =AppUser();
        print("Hello $document.get['uid'].toString()");
        appUser!.uid = document.get('uid').toString();
        appUser!.name = document.get('name').toString();
        appUser!.email = document.get('email').toString();
        appUser!.imageUrl = document.get('imageUrl').toString();
      }
    else{print("error");}
  return appUser;


  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<dynamic>(
      future: fetchUserDetails(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){ return ListView(
          padding: EdgeInsets.all(16),
          children: [
            Card(
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.all(8)
                  ),
                  InkWell(
                    child: CircleAvatar(
                      backgroundImage: null,
                      radius: 100,

                    ),
                    onTap: () {
                      //image picker logic
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(appUser!.name.toString(),
                    style: TextStyle(color: Colors.blueGrey, fontSize: 20),),
                  Text(appUser!.email.toString(),
                    style: TextStyle(color: Colors.black38, fontSize: 15),),
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
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text(
                "Manage Orders",
              ),
              subtitle: Text("Manage your Order History here"),
              trailing: Icon(Icons.keyboard_arrow_right_sharp),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                "Manage Addresses",
              ),
              subtitle: Text("Update Your Addresses for Delivery"),
              trailing: Icon(Icons.keyboard_arrow_right_sharp),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text(
                "Help",
              ),
              subtitle: Text("Raise your Queries"),
              trailing: Icon(Icons.keyboard_arrow_right_sharp),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(Icons.document_scanner_outlined),
              title: Text(
                "Terms & Conditions",
              ),
              subtitle: Text("Check our Terms and Conditions"),
              trailing: Icon(Icons.keyboard_arrow_right_sharp),
              onTap: () {

              },
            ),
          ],
        );}
    );
  }
}
