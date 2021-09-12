

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/model/user.dart';
// final APP_NAME="Loving Food";
// final RESTAURANT_COLLECTION="restaurants";
// final DISHES_COLLECTION="dishes";
// final APP_ICON="icon.png";
// final ADMIN_EMAIL="admin@example.com";
// final Color APP_COLOR=Colors.green;
// final String USERS_COLLECTION="users";


class Util{
  static String APP_NAME="Loving Food";
  static String RESTAURANT_COLLECTION="restaurants";
  static String DISHES_COLLECTION="dishes";
  static String USERS_COLLECTION="users";
  static String CART_COLLECTION="cart";
  static String EXTRAS_COLLECTION="extras";
  static String PAYMENTMETHODS_COLLECTION="methods";
  static String ORDER_COLLECTION="order";
  static String ADDRESS_COLLECTION="address";
  static String APP_ICON="icon.png";
  static String ADMIN_EMAIL="admin@example.com";
  static Color APP_COLOR=Colors.green;
  static AppUser? appUser;
  static Map total={};
  static bool checkpath=false;
  static String filter="all";

  static fetchUserDetails()async{
    print("static fetchUserDetails() async");
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    print("uid: $uid");
    DocumentSnapshot document = await FirebaseFirestore.instance.collection(Util.USERS_COLLECTION).doc(uid).get();
    print("document: ${document.id}");
    Util.appUser = AppUser();

    Util.appUser!.uid = document.get('uid').toString();
    print("document.get('uid').toString() = ${document.get('uid').toString()};");
    print("Util.appUser!.uid: ${Util.appUser!.uid}");

    Util.appUser!.name = document.get('name').toString();
    print("Util.appUser!.name: ${Util.appUser!.name}");
    Util.appUser!.email = document.get('email').toString();
    print("Util.appUser!.email: ${Util.appUser!.email}");
    Util.appUser!.imageUrl = document.get('imageUrl').toString();
    Util.appUser!.imageUrl = document.get('imageUrl').toString();
    Util.appUser!.isAdmin = document.get("isAdmin");
    Util.appUser!.isAdmin = document.get('isAdmin');


    return Util.appUser;
  }
}