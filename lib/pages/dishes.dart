import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/custom-widgets/counter.dart';
import 'package:fooddelivery/model/user.dart';
import 'package:fooddelivery/pages/dishes-data-page.dart';
import 'package:fooddelivery/util/constants.dart';
class DishesPage extends StatefulWidget {
  String? restaurantID;
  DishesPage({Key? key, this.restaurantID}) : super(key: key);

  @override
  _DishesPageState createState() => _DishesPageState();
}

class _DishesPageState extends State<DishesPage> {
  String? email;
  fetchRestaurants(){
    //Stream is a Collection i.e. a List of QuerySnapshot
    //QuerySnapshot is our Document :)
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection(RESTAURANT_COLLECTION).doc(widget.restaurantID).collection(DISHES_COLLECTION).snapshots();
    return stream;
  }
  AppUser? appUser;
  Future fetchUserDetails() async {
    print("hello");
    String uid = await FirebaseAuth.instance.currentUser!.uid.toString();
    var document = await FirebaseFirestore.instance.collection(
        USERS_COLLECTION).doc(uid).get();
    // appUser =AppUser();
    // print("Hello $document.get['uid'].toString()");
    // appUser!.uid = document.get('uid').toString();
    // appUser!.name = document.get('name').toString();
    // appUser!.email = document.get('email').toString();
    // appUser!.imageUrl = document.get('imageUrl').toString();

    if (document.exists)
    {

      appUser =AppUser();
      // print("Hello $document.get['uid'].toString()");
      // appUser!.uid = document.get('uid').toString();
      // appUser!.name = document.get('name').toString();
      // appUser!.email = document.get('email').toString();
      // appUser!.imageUrl = document.get('imageUrl').toString();
      appUser!.isAdmin = document.get('isAdmin');
    }
    else{print("error");}
    return appUser;


  }
  check<Widget>(){
    // FirebaseApp secondaryApp = Firebase.app('FoodDelivery');
    User? user = FirebaseAuth.instance.currentUser;
    // firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instanceFor(app: secondaryApp);
    // firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref(user!.uid);
    // print("hi");
    return FutureBuilder(
        future: fetchUserDetails(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if (appUser!.isAdmin==true)
          {
            return IconButton(
                onPressed: (){

                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context)=>
                          DishesDataPage(restaurantID: widget.restaurantID,)
                  )
                  );
                },
                icon: Icon(Icons.add)
            );
          }
          else
            return Container();
        });

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME),
        backgroundColor: Colors.yellow,
        actions: [
          check(),
          IconButton(
            onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, "/login");
            }, icon: Icon(Icons.logout),
            tooltip: "Log Out",

          ),

        ],
      ),
      body: StreamBuilder(
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
                      Navigator.pushNamed(context, "");
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
                                      Text(" ${map["discount"]}", textAlign: TextAlign.justify, style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey),),
                                      Text("\u20b9 ${map["price"].toString()} for one ", textAlign: TextAlign.justify, style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey),)
                                    ],
                                  ),
                                  Counter()
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
      ),
    );
  }
}















