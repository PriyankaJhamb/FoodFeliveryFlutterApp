import 'package:flutter/material.dart';

class PageOne extends StatefulWidget {
  PageOne({Key? key}) : super(key: key);

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  int? table_number;
  TextEditingController controllerTN = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tables"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Enter the table number:"),
            TextField(
              controller: controllerTN,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: (){
                  // table_number= controllerTN.text as int;
                  table_number= int.parse(controllerTN.text); ;
                  Navigator.pushNamed(context, "/two", arguments: table_number);
                },
                child: Text("SUBMIT")
            )

          ],
        ),
      ),
    );
  }
}

class PageTwo extends StatefulWidget {

  PageTwo({Key? key}) : super(key: key);

  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override


  // List<Widget> widgets=[];
  getwidgets({int TN=0}){
    var widgets = <Widget>[];
    widgets.add(
        Column(

          children: [
            SizedBox(
              height: 100,
            ),
            Text("Table of ${TN}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            SizedBox(
              height: 50,
            )
          ],
        ));
    for(int i=0;i<=10;i++)
      {
        widgets.add(
            Column(
              children: [
                Text("${TN} * ${i} = ${TN*i}"),
                Divider()
              ],
        )
        );
      }
    widgets.add(
      ElevatedButton(
        onPressed: (){
          Navigator.pop(context, TN);
        },
        child: Text("Go to Home"),
      )
    );
    return widgets;
  }
  Widget build(BuildContext context) {
    int TN = ModalRoute.of(context)!.settings.arguments as int ;

    return Scaffold(
      appBar: AppBar(
        title: Text("Tables"),
      ),
      body:  ListView(
          children: getwidgets(TN: TN),
        ),


    );
  }
}
