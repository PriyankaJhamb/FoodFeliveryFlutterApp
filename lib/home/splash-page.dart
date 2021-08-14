import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {

  navigateToHome(BuildContext context){

    // String uid = FirebaseAuth.instance.currentUser!.uid;
    String uid = FirebaseAuth.instance.currentUser!=null ? FirebaseAuth.instance.currentUser!.uid : "";


    Future.delayed(
        Duration(seconds: 3),
            (){
          Navigator.pushNamed(context, "/home");
          if(uid.isNotEmpty){
            Navigator.pushReplacementNamed(context, "/home");
          }else {
            Navigator.pushReplacementNamed(context, "/login");
          }
        }
    );
  }


  @override
  Widget build(BuildContext context) {

    navigateToHome(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("icon.png"),
            SizedBox(height: 8),
            Text("Loving Food", style: TextStyle(color:Colors.redAccent, fontSize: 24)),
            Divider(),
            SizedBox(height: 4),
            Text("We deliver Fresh", style: TextStyle(color: Colors.yellow, fontSize: 20),),


          ],
        )
      )
    );
  }
}
