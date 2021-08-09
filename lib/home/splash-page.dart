import 'dart:ui';

import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {

  navigatorToHome( BuildContext context)
  {
    Future.delayed(
      Duration(seconds: 3),
        (){
           //Navigator.pushNamed(context, '/home');
          Navigator.pushReplacementNamed(context, '/home');
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    navigatorToHome(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("icon.png"),
            SizedBox(height: 8),
            Text("Foodie", style: TextStyle(color:Colors.redAccent, fontSize: 24)),
            Divider(),
            SizedBox(height: 4),
            Text("We deliver Fresh", style: TextStyle(color: Colors.yellow, fontSize: 20),),


          ],
        )
      )
    );
  }
}
