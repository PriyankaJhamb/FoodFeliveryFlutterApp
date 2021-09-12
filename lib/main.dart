import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fooddelivery/auth/login-page.dart';
import 'package:fooddelivery/auth/register-page.dart';
import 'package:fooddelivery/db/provider.dart';
import 'package:fooddelivery/home/home-page.dart';
import 'package:fooddelivery/home/splash-page.dart';
import 'package:fooddelivery/pages/cart-page.dart';
import 'package:fooddelivery/pages/dishes-data-page.dart';
import 'package:fooddelivery/pages/payment-methods.dart';
import 'package:fooddelivery/pages/show-orders.dart';
import 'package:fooddelivery/profile/google-maps-with-location.dart';
import 'package:fooddelivery/pages/location-page.dart';
import 'package:fooddelivery/pages/restaurants-data-page.dart';
import 'package:fooddelivery/profile/user-addresses.dart';
import 'package:provider/provider.dart';

// main function represents main thread
// whatever we code in main, is executed by main thread
// that too in a sequence
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel? channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

Future<void> main() async{
  // to execute the app created by us
  // MyApp -> Object
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => DataProvider(),)
    ],
    child: MyApp(), // For MyApp and all the widgets under the tree, we have DataProvider from where we can accrss the data
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        // Navigator.pushNamed(context, '/message',
        //     arguments: MessageArguments(message, true));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {

      RemoteNotification? notification = message!.notification;
      AndroidNotification? android = message.notification!.android;

      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin!.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                channel!.description,
                playSound: true,
                //sound: AndroidNotificationSound()
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Navigator.pushNamed(context, '/message',
      //     arguments: MessageArguments(message, true));
    });
  }

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
        primarySwatch: Colors.green,
      ),
      routes: {
        "/": (context) => SplashPage(),
        "/home": (context)=>HomePage(),
        "/login": (context)=>LoginPage(),
        "/register": (context)=>RegisterUserPage(),
        "/resdata": (context)=>RestaurantsDataPage(),
        "/dishdata": (context)=>DishesDataPage(),
        "/location": (context)=>LocationPage(),
        "/cart": (context)=>CartPage(),
        "/useraddresses": (context)=>UserAddressesPage(),
        "/googlemap": (context)=>GoogleMapsPage(),
        "/paymentmethods": (context)=>PaymentMethodsPage(),
        "/showorders": (context)=>ShowOrders(),


        // "/imagep": (context)=>ImagePickerPage()
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

