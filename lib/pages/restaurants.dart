
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantsPage extends StatefulWidget {
  const RestaurantsPage({Key? key}) : super(key: key);

  @override
  _RestaurantsPageState createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {

  fetchRestaurants(){
    //Stream is a Collection i.e. a List of QuerySnapshot
    //QuerySnapshot is our Document :)
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection("restaurants").snapshots();
    return stream;
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: fetchRestaurants(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text("SOMETHING WENT WRONG", style: TextStyle(color: Colors.red)),
            );
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }


          //List data = [10, 20, 30];
          //List data1 = data.map((e) => e+10).toList();

          /*List<DocumentSnapshot> snapshots = snapshot.data!.docs;
          List<ListTile> tiles = [];
          snapshots.forEach((document) {
            Map<String, dynamic> map = document.data()! as Map<String, dynamic>;
            tiles.add(
                ListTile(
                  title: Text(map['name']),
                  subtitle: Text(map['categories']),
                )
            )
          });*/


          return ListView(
            children:snapshot.data!.docs.map<Widget>((DocumentSnapshot document){
              Map<String, dynamic> map=document.data()! as Map<String, dynamic>;
              return Container(
                child: Column(
                  children: [
                    Image.network(map["imageUrl"]),
                    Text(map["name"]),
                    Text(map["categories"])
                  ],
                ),
                  margin: EdgeInsets.all(9),
                  decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  borderRadius: BorderRadius.all(
                      Radius.circular(10)
                  ),
                    border: Border.all(
                      color: Colors.red
                    )
                        
                      )

              );
                // title: Text(map["name"]),
                // subtitle: Text(map['categories']),
            }).toList()
          );
        }
    );
  }
}
