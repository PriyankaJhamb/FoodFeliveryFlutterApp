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
  static String ADDRESS_COLLECTION="addressell";
  static String APP_ICON="icon.png";
  static String ADMIN_EMAIL="admin@example.com";
  static Color APP_COLOR=Colors.green;
  static AppUser? appUser;
  static Map total={};

  static fetchUserDetails() async{
    String uid = await FirebaseAuth.instance.currentUser!.uid.toString();
    DocumentSnapshot document = await FirebaseFirestore.instance.collection(Util.USERS_COLLECTION).doc(uid).get();
    Util.appUser = AppUser();

    Util.appUser!.uid = document.get('uid').toString();
    Util.appUser!.name = document.get('name').toString();
    Util.appUser!.email = document.get('email').toString();
    Util.appUser!.imageUrl = document.get('imageUrl').toString();
    Util.appUser!.isAdmin = document.get("isAdmin");
  }
}