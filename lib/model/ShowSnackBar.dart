import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Show_Snackbar{
  String message;
  BuildContext context;
  Show_Snackbar({required this.context,required this.message}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(this.message.toString()),
      duration: Duration(seconds: 3),
    )
    );
  }
}