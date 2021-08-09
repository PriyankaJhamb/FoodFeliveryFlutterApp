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
  var content = <Map<String, String>>[
    {
      'title': "Tesla",
      'subtitle': "All news about Tesla"
    },
    {
      'title': "United States",
      'subtitle': "Top Headlines in US"
    },
    {
      'title': "Tech Crunch",
      'subtitle': "Top headlines from Tech Crunch"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: content.length,
        itemBuilder: (context, index) {
          var leadingText = "";
          var StringList = content[index]["title"]!.split(" ");
          if (StringList.length >= 2) {
            leadingText = StringList[0][0] + StringList[1][0];
          }
          else if (StringList.length == 1) {
            leadingText = content[index]["title"]![0];
          }
          return ListTile(
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
            title: Text(content[index]["title"]!),
            subtitle: Text(content[index]["subtitle"]!),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {},
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.white24,
          );
        }
    );
  }
}
