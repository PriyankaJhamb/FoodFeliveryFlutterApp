
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/pages/dishes.dart';

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
    return StreamBuilder<dynamic>(
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
              return InkWell(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> DishesPage(
                        restaurantID: document.id,
                      )));
                },
                child:Container(
                  padding: EdgeInsets.only(bottom: 9,),
                  margin: EdgeInsets.all(9),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      border: Border.all(
                          color: Colors.grey
                      )

                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 250,
                        width: 500,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.only(topLeft:Radius.circular(8), topRight: Radius.circular(8)),
                            color: Colors.black12,
                            image: DecorationImage(
                                image: NetworkImage(map["imageUrl"]),
                                fit: BoxFit.fill
                            )
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.all(4),
                        child: Column(
                          children: [Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(" ${map["name"]}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),textAlign: TextAlign.justify),
                                Container(
                                  height: 20,
                                  width: 45,
                                  margin: EdgeInsets.only(right: 4, top: 2, bottom: 0),
                                  child: TextButton(
                                    onPressed: (){},
                                    child: Text("${map["ratings"].toString()}⭐",style: TextStyle(color: Colors.white),),
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      padding: EdgeInsets.all(0.0),

                                    ),
                                  ),
                                )
                              ]
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(" ${map["categories"]}", textAlign: TextAlign.justify, style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey),),
                              Text("\u20b9 ${map["pricePerPerson"].toString()} for one ", textAlign: TextAlign.justify, style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey),)
                            ],
                          ),
                          ]
                        ),
                      ),
                      // Image.network(map["imageUrl"], fit: BoxFit.fill,),

                   ],
                  ),
              ),
              );
                // title: Text(map["name"]),
                // subtitle: Text(map['categories']),
            }).toList()
          );
        }
    );
  }
}
