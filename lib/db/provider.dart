import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/util/constants.dart';

class DataProvider extends ChangeNotifier{
  late FirebaseFirestore db;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? ordersSubscription;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? orders;

  DataProvider(){
    db= FirebaseFirestore.instance;
    fetchOrders();
  }

  fetchOrders(){
    ordersSubscription= db.collection(Util.USERS_COLLECTION).doc(Util.appUser!.uid).collection(Util.ORDER_COLLECTION).snapshots().listen((event) {
      print("DATA: ${event.docs.first.data()}");
      orders=event.docs;
      notifyListeners();

    });
  }

}