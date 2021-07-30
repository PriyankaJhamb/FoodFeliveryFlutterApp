import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(MyApp());
}

class  MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.white12),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: friends()
        )
    );
  }
}

class friends extends StatefulWidget {
  const friends({Key? key}) : super(key: key);

  @override
  _friendsState createState() => _friendsState();
}

class _friendsState extends State<friends> {
  Map Friends={
    'Vrishti': ['purple', Colors.purpleAccent],
    'Amanjot': ['blue', Colors.blue],
    'Mehak' : ['red', Colors.red],
    'Neha' : ['green', Colors.green]
  };
  var Friendsname=<Widget>[];
  var resultedcolor=Colors.black12;
  getwidgets(){
    Friendsname.clear();
    Friends.forEach((key, value) {
      Friendsname.add(
          InkWell(
            child: Row( children: [ Text("${key} \n " , style: TextStyle(color: Colors.black) ),SizedBox(width: 10), Text( "${value[0]}", style: TextStyle(color: Colors.black) )]),
            onTap: (){
              setState(() {
                resultedcolor=value[1];


              });
            },
          )
      );
    });
    return Friendsname;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [Container(
            height: (MediaQuery.of(context).size.height) / 2,
            color: Colors.white,
            child: ListView(
                children: getwidgets()
            )
        ),
          Container(
              height: (MediaQuery.of(context).size.height) / 2,
              color: resultedcolor
          )
        ]
    );
  }
}
