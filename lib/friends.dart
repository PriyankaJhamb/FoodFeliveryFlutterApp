import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(MyApp());
}

class  MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.blue),
    debugShowCheckedModeBanner: false,
    home: Scaffold(
    appBar: AppBar(
      title: Text("MyApp"),
      backgroundColor: Colors.black12,
    ),
      body: friends()
    )
    );
  }
}

class friends extends StatefulWidget {
  const friends({Key? key}) : super(key: key);

  @override
  _friendsState createState() => _friendsState();
}

class _friendsState extends State<friends> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
    );
  }
}
