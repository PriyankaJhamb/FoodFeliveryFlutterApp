import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/pages/restaurants-data-page.dart';
import 'package:fooddelivery/pages/restaurants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int index = 0;


  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      RestaurantsPage(),
      Column(
        children: [Center(child:ElevatedButton(onPressed: (){Navigator.pushNamed(context, "/resdata");}, child: Text("Press to input the details of Restaurant", textAlign: TextAlign.center,)))],
      ),
      Center(child: Text("PROFILE PAGE")),
    ];

    return Scaffold(

      appBar: AppBar(
        title: Text("Loving Food"),
        backgroundColor: Colors.yellow,
        actions: [
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