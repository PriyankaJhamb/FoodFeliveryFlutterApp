
import 'package:flutter/material.dart';


void main(){
  runApp(MyApp());
}

class  MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.blue),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text("MyApp"),
              backgroundColor: Colors.black12,
            ),
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
    'Vrishti': ['Purple', Colors.purple],
    'Amanjot': ['Blue', Colors.blue],
    'Mehak' : ['Red', Colors.red],
    'Neha' : ['Green', Colors.green]
  };
  var Friendsname=<Widget>[];
  var resultedcolor=Colors.black12;
  getwidgets(){
    Friendsname.clear();
    Friends.forEach((key, value) {
      Friendsname.add(
          InkWell(
            child: Row(
                children: [
                  Text("${key} \n " ,
                      style: TextStyle(
                        color: Colors.brown,
                        fontSize: 23,
                        fontFamily: 'RobotoMono',
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        decorationStyle:TextDecorationStyle.wavy,
                      ) ),
                  SizedBox(width: 20),
                  SizedBox(height:10),
                  Text(
                      "${value[0]}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          shadows: [
                            Shadow(
                                blurRadius: 10.0,
                                color: value[1],
                                offset: Offset(5.0, 5.0))])) ]),
            onTap: (){
              setState(() {
                resultedcolor=value[1];


              });
            },
          )

      );
      Friendsname.add(Divider(color: Colors.black,));
    });
    return Friendsname;
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
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
