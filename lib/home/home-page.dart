import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/image-picker.dart';
import 'package:fooddelivery/pages/dishes-data-page.dart';
import 'package:fooddelivery/pages/restaurants-data-page.dart';
import 'package:fooddelivery/pages/restaurants.dart';
import 'package:fooddelivery/util/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? email;
  int index = 0;


  @override
  Widget build(BuildContext context) {
    print("Hi: ${context.runtimeType}");
    List<Widget> widgets = [
      RestaurantsPage(),
      Center(child: Text("Search Page"),),
      ImagePickerPage(),
    ];

    check<Widget>(){
      User? user = FirebaseAuth.instance.currentUser;
      email=user!.email;
      if (email==ADMIN_EMAIL && index==0)
      {
        return IconButton(
            onPressed: (){

              Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context)=>
                      RestaurantsDataPage()
              )
              );
            },
            icon: Icon(Icons.add)
        );
      }
      else
        return Container();
    }
    return Scaffold(

      appBar: AppBar(
        title: Text(APP_NAME),
        backgroundColor: Colors.yellow,
        actions: [
          check(),
          IconButton(
            onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, "/login");
            }, icon: Icon(Icons.logout),
            tooltip: "Log Out",
          )
        ],
      ),

      body: widgets[index],

      bottomNavigationBar: BottomNavigationBar(
        items: [
          // 0
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "HOME"
          ),
          // 1
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "SEARCH"
          ),
          //2
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: "PROFILE"
          )
        ],

        currentIndex: index,
        selectedFontSize: 16,
        selectedItemColor: Colors.yellow,
        onTap: (idx){ // idx will have value of the index of BottomNavBarItem
          setState(() {
            index = idx;
          });
        },
      ),

    );
  }
}