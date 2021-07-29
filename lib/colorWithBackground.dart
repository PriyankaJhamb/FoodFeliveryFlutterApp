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
  Map colors={'pink':'Pink', 'black':'Black', 'brown':'Brown', 'blue':'Blue','yellow':'Yellow'};
  getTextWidgets(){
    var textWidgets=<Widget>[];
    colors.forEach((key, value) {
      textWidgets.add(Text(key));
      textWidgets.add(Divider());
    });
    return textWidgets;
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getTextWidgets()
    );
  }
}
