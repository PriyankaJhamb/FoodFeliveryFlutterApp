import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.blue),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
              title: Text("MyApp"),
              backgroundColor: Colors.tealAccent
          ),
          body: colorPage(),
        )
    );
  }
}

class colorPage extends StatefulWidget {
  const colorPage({Key? key}) : super(key: key);

  @override
  _colorPageState createState() => _colorPageState();
}

class _colorPageState extends State<colorPage> {
  Map colors={'pink':Colors.pink, 'brown':Colors.brown, 'blue':Colors.blue,'yellow':Colors.yellow, 'black':Colors.black};
  var scaffoldColor=Colors.orange;
  getTextWidgets(){
    var textWidgets=<Widget>[];
    colors.forEach((key, value) {
      textWidgets.add(
        Row(
          children: [
            InkWell(
              child: Row(
              children: [
                Text(key)
              ],
              ),
              onTap: (){
                setState(() {
                  scaffoldColor=value;
                });
              },
            )
          ],
        )
      );

    });
    return textWidgets;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffoldColor,
        body: ListView(
            children: getTextWidgets()
    )
    );
  }
}