
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/pages/dishes.dart';
import 'package:fooddelivery/util/constants.dart';

class RestaurantsPage extends StatefulWidget {
  // String filter=Util.filter;
  RestaurantsPage({Key? key}) : super(key: key);


  @override
  _RestaurantsPageState createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {

  fetchRestaurants(){
    Stream<QuerySnapshot> stream;
    //Stream is a Collection i.e. a List of QuerySnapshot
    //QuerySnapshot is our Document :)
    if (Util.filter=="all")
      {
        print("all");
        stream = FirebaseFirestore.instance.collection(Util.RESTAURANT_COLLECTION).snapshots();

      }
    else
      {
        print("widget.filter: ${Util.filter}");
        stream= FirebaseFirestore.instance.collection(Util.RESTAURANT_COLLECTION)
            .where("tags", arrayContains:Util.filter).snapshots();

      }
    return stream;
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
        stream: fetchRestaurants() ,
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
               shrinkWrap: true,
               physics: ClampingScrollPhysics(
               ),
               scrollDirection: Axis.vertical,

               children:snapshot.data!.docs.map<Widget>((DocumentSnapshot document){
                 Map<String, dynamic> map=document.data()! as Map<String, dynamic>;
                 return InkWell(
                   onTap: (){
                     Navigator.push(context,
                         MaterialPageRoute(builder: (context)=> DishesPage(
                           restaurantID: document.id,
                           restaurantName: map["name"]
                         )));
                   },
                   child:Card(
                    semanticContainer: true,
                     margin: EdgeInsets.all(10),
                     elevation: 5,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(20)
                     ),
                     child:
                     // Container(
                       // padding: EdgeInsets.only(bottom: 9,),
                       // margin: EdgeInsets.all(9),
                       // decoration: BoxDecoration(
                       //     shape: BoxShape.rectangle,
                       //     borderRadius: BorderRadius.all(Radius.circular(3.0)),
                       //     border: Border.all(
                       //         color: Colors.white
                       //     )
                       //
                       // ),
                       // child:
                       Column(
                         children: [
                           ClipRRect(
                             // borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                             child: Container(
                               height: 250,
                               width: 500,
                               decoration: BoxDecoration(
                                   shape: BoxShape.rectangle,
                                   borderRadius: BorderRadius.only(topLeft:Radius.circular(20), topRight: Radius.circular(20)),
                                   color: Colors.black12,
                                   image: DecorationImage(
                                       image: NetworkImage(map["imageUrl"]),
                                       fit: BoxFit.fill
                                   )
                               ),
                             ),
                           ),

                           Container(
                             margin: EdgeInsets.all(4),
                             child: Column(
                               children: [
                                 Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10)),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text(" ${map["name"]}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),textAlign: TextAlign.justify),
                                     Container(
                                       margin: EdgeInsets.only(right: 4, top: 2, bottom: 0),
                                       padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                                       decoration: BoxDecoration(
                                         color: Colors.green,
                                         borderRadius: BorderRadius.circular(5)
                                       ),
                                       child: Row(
                                         children: [
                                           Text(
                                             "${map["ratings"].toString()}",
                                             style: TextStyle(
                                                 color: Colors.white,
                                               fontSize: 13
                                             ),
                                           ),
                                           Icon(
                                             Icons.star,
                                             color: Colors.white,size: 15,
                                           )
                                         ],
                                       ),
                                     )
                                   ]
                               ),
                              Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10)),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text(" ${map["categories"]}", textAlign: TextAlign.justify, style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey),),
                                   Text("\u20b9 ${map["pricePerPerson"].toString()} for one ", textAlign: TextAlign.justify, style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey),)
                                 ],
                               ),
                               Padding(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10)),
                               ]
                             ),
                           ),
                           // Image.network(map["imageUrl"], fit: BoxFit.fill,),

                        ],
                       ),
                 // ),
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
