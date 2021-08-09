import 'package:flutter/material.dart';
import 'package:fooddelivery/home/home-page.dart';
import 'package:fooddelivery/home/splash-page.dart';

// main function represents main thread
// whatever we code in main, is executed by main thread
// that too in a sequence
void main() {
  // to execute the app created by us
  // MyApp -> Object
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => SplashPage(),
        "/home": (context)=>HomePage(),

      },
      initialRoute: "/",
    );
  }
}
/*
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My App"),
      ),
      body: ProfilePage(),
    );
  }
}

 */