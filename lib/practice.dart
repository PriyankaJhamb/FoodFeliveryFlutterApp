import 'package:flutter/material.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("My App"),
          backgroundColor: Colors.green,

        ),
        body: Change(),
      ),
    );
  }
}


class Change extends StatefulWidget {
  const Change({Key? key}) : super(key: key);

  @override
  _ChangeState createState() => _ChangeState();
}

class _ChangeState extends State<Change> {
  var myDefault_colors = {
    'Orange' : Colors.orange,
    'Black' : Colors.black,
    'Cyan' : Colors.cyan,
    'Brown': Colors.brown,
    'Pink' : Colors.pink,
    'Blue' : Colors.blue
  };

  var scaffoldColor=Colors.white;

  getColors(){
    var Colors_widgets = <Widget>[];

    myDefault_colors.forEach((key, value) {
      Colors_widgets.add(
          Row(

            children: [
              InkWell(
                child: Row(
                    children:[
                      Column(
                          children: [Text("   "+key+"\t\t",style: TextStyle(color: Colors.teal,fontSize: 17,fontWeight: FontWeight.w700),)]
                      ),
                      Column(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: value,
                              ),
                            )
                          ]
                      )
                    ]
                )
                ,onTap: (){
                setState(() {
                  scaffoldColor = value;
                });
              },
              )
            ],
          )
      );
    });
    return Colors_widgets;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Container(
          child: Column(
              children: [
                Column(
                    children: [
                      SizedBox(height:20)
                    ]
                ),
                Column(
                    children:
                    getColors()
                ),
              ]
          )
      ),
    );
  }
}