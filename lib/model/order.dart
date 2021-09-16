import 'package:cloud_firestore/cloud_firestore.dart';

class Order{
  List? dishes;
  int? total;
  String? paymentMethod;
  String? address;
  Timestamp? timestamp;
  String? id;


  Order({this.dishes, this.total, this.paymentMethod, this.address, this.timestamp, this.id});

  @override
  String toString() {
    return 'Order{dishes: $dishes, total: $total, paymentMethod: $paymentMethod, address: $address, timestamp: $timestamp, id: $id}';
  }

  toMap()=>{
    'dishes': dishes,
    'total': total,
    'paymentMethod' : paymentMethod,
    'address':address,
    'timestamp': timestamp,
    'id':id
  };
}