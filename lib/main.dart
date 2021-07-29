import 'package:flutter/material.dart';
void main()
{
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("MyApp"),
          backgroundColor: Colors.tealAccent,
        ),
        body: HomePage(),
      )
    );
  }
}

class HomePage extends StatelessWidget{
  HomePage({Key? key}): super(key:key);

  @override
  Widget build(BuildContext context)
  {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Welcome to MyApp"),
          SizedBox(height:16),
          Divider(),
        Text("Version 1.0"),
        Text("Name: Hawk")
        ],
      )
    );
  }
}