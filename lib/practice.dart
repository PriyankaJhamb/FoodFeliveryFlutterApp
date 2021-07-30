import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: Home(),
    ),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var col;
  var listOfFriends = {'A':Colors.brown, 'B':Colors.green, 'C':
  Colors.deepPurple, 'D': Colors.yellow};
  getWidgets(){
    var widgets = <Widget>[];
    listOfFriends.forEach((key, value) {
      widgets.add(InkWell(
        child: Text(key, style: TextStyle(color: Colors.pink)),
        onTap: (){
          setState(() {
            col = value;
          });
        },
      ));
      widgets.add(Divider());
    });
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return  ListView(
        children: [Container(
            height: (MediaQuery.of(context).size.height) / 2,
            color: Colors.white,
            child: ListView(
                children: getWidgets()
            )
        ),
          Container(
              height: (MediaQuery.of(context).size.height) / 2,
              color: col
          )
        ]
    );
  }
}