import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final Color lightpink = Color.fromARGB(25, 216, 11, 231);

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 70,
        ),
        Container(

          height: 100,
          width:100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: lightpink,
            image: DecorationImage(
                image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                fit: BoxFit.fill
            ),
          ),
        ),

        Text("John Watson", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        Text("Software Engineer Manager (Fresher)"),
        SizedBox(
          height: 30,
        ),
        Center(
            child: Container(
                padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                height: 150,
                width: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: lightpink,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [Text("Followers", textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),)],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [Text("Following", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink))],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [Text("Articles", textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink))],
                        )

                      ]
                  ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        Column(
                          children: [Text("11K", textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),)],
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        Column(
                          children: [Text("10K", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink))],
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        Column(
                          children: [Text("100", textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink))],
                        )

                      ] ),
                    SizedBox(
                        height: 40
                    ),
                    Row(

                      children: [Text("                      Explore More Articles",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink))],
                    ),
                    SizedBox(
                        height: 10
                    ),
                    Container(

                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.pink,
                        ),

                        child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                            children: [InkWell(
                              child:  Text("Explore Now!", textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                              onTap: (){},
                            )])
                    ),

                  ],
                )
            ))
      ],
    );
  }
}
