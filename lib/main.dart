import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/auth/login-page.dart';
import 'package:fooddelivery/auth/register-page.dart';
import 'package:fooddelivery/home/home-page.dart';
import 'package:fooddelivery/home/splash-page.dart';
import 'package:fooddelivery/pages/restaurants-data-page.dart';

// main function represents main thread
// whatever we code in main, is executed by main thread
// that too in a sequence
Future<void> main() async{
  // to execute the app created by us
  // MyApp -> Object
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        "/login": (context)=>LoginPage(),
        "/register": (context)=>RegisterUserPage(),
        "/resdata": (context)=>RestaurantsDataPage()
      },
      initialRoute: "/",
    );
  }
}

// class HomePage extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return PageOne();
//   }
// }

