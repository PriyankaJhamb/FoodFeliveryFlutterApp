import 'package:cloud_firestore/cloud_firestore.dart';

class Order{
  List? dishes;
  int? total;
  String? paymentMethod;
  String? address;
  Timestamp? timestamp;

  Order({this.dishes, this.total, this.paymentMethod, this.address, this.timestamp});

  @override
  String toString() {
    return 'Order{dishes: $dishes, total: $total, paymentMethod: $paymentMethod, address: $address, timestamp: $timestamp}';
  }

  toMap()=>{
    'dishes': dishes,
    'total': total,
    'paymentMethod' : paymentMethod,
    'address':address,
    'timestamp': timestamp
  };
}