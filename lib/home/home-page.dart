import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  int index=0;

  List<Widget> widgets=[
    Center(child: Text("HOME PAGE")),
    Center(child: Text("SEARCH PAGE")),
    Center(child: Text("PROFILE PAGE")),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text("LovingFood"),
       backgroundColor: Colors.yellow,
       leading: Container(
         height: 28,
         width: 28,
         decoration: BoxDecoration(
             shape: BoxShape.circle,
             color: Colors.yellow,

             image: DecorationImage(
                 image: AssetImage("icon.png"),
                 fit: BoxFit.fill
             ),
         ),
       ),
       actions: [
         IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart), tooltip: "Shopping Cart",)
       ],

     ),
      body: widgets[index],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          //0
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "HOME"),
          //1
          BottomNavigationBarItem(icon: Icon(Icons.search),label: "SEARCH"),
          //2
          BottomNavigationBarItem(icon: Icon(Icons.account_box),label: "PROFILE"),

        ],
        currentIndex: index,
        selectedFontSize: 16,
        selectedItemColor: Colors.deepOrange,
        onTap: (idx){
          setState(() {
            index=idx;
          });
        },
      ),
    );
  }
}
