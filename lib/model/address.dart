import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class UserAddress{
  String? label;
  GeoPoint?  geoPoint;
  String? address;


  UserAddress(this.label, this.geoPoint, this.address);

  @override
  String toString() {
    return 'address{label: $label, geoPoint: $geoPoint,address: $address}';
  }


  toMap()=>{
    'label': label,
    'geopoint': geoPoint,
    'address': address
  };
}




