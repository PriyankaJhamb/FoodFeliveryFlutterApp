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
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8),
      children: <ListTile>[
        ListTile(
          leading: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange
            ),
            child: Center(
              child: Text("T"),
            ),
          ),
          title: Text("Tesla"),
          subtitle: Text("All news about Tesla"),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: (){},
        ),
        ListTile(
          leading: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange
            ),
            child: Center(
              child: Text("US"),
            ),
          ),
          title: Text("United States"),
          subtitle: Text("Top Headlines in US"),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: (){},
        ),
        ListTile(
          leading: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange
            ),
            child: Center(
              child: Text("TC"),
            ),
          ),
          title: Text("Tech Crunch"),
          subtitle: Text("Top headlines from Tech Crunch"),
          trailing: Icon(Icons.keyboard_arrow_right_sharp),
          onTap: (){},
        )

      ],

    );
  }
}
