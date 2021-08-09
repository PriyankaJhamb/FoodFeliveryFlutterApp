import 'package:flutter/material.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  var content=<Map<String,String>>[
    {
      'title':"Tesla",
      'subtitle':"All news about Tesla"
    },
    {
      'title':"United States",
      'subtitle':"Top Headlines in US"
    },
    {
      'title':"Tech Crunch",
      'subtitle':"Top headlines from Tech Crunch"
    }
  ];

  getWidget()
  {
    var tiles=<Widget>[];
    content.forEach((element) {
      var leadingText="";
      var StringList= element["title"]!.split(" ");
      if (StringList.length>=2)
        {
          leadingText=StringList[0][0]+StringList[1][0];
        }
      else if(StringList.length==1)
        {
          leadingText=element["title"]![0];
        }
      tiles.add(ListTile(
        leading: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange
          ),
          child: Center(
            child: Text(leadingText),
          ),
        ),
        title: Text(element["title"]!),
        subtitle: Text(element["subtitle"]!),
        trailing: Icon(Icons.keyboard_arrow_right_sharp),
        onTap: (){},
      ));
    });
    return tiles;
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8),
      children:getWidget()
    );
  }
}
