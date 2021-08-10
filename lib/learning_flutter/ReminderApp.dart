import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/learning_flutter/colorclickable.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ReminderApp"),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          InkWell(
            child: Text("Edit", style: TextStyle(color: Colors.blue),textAlign: TextAlign.right,),
          )
        ],
      ),
    );
  }
}

