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
  String? restaurantName;

  DishesPage({Key? key, this.restaurantID, this.restaurantName}) : super(key: key);

  @override
  _DishesPageState createState() => _DishesPageState();
}

class _DishesPageState extends State<DishesPage> {
  String? email;
  AppUser? appUser;

  discount(int percentageDiscount, int flatDiscount){
    if (percentageDiscount==0 && flatDiscount==0)
      {
        return " No Discount";
      }
    else if( percentageDiscount!=0 && flatDiscount!=0)
    {
      return " ${percentageDiscount}% OFF \n Discount UP TO ₹${flatDiscount} ";
    }
    else if( percentageDiscount!= 0)
      {
        return " ${percentageDiscount}% OFF ";
      }
    else if( flatDiscount!=0 )
      {
        return " Discount UP TO ₹${flatDiscount} ";
      }

  }

  fetchRestaurants() {
    //Stream is a Collection i.e. a List of QuerySnapshot
    //QuerySnapshot is our Document :)
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection(Util.RESTAURANT_COLLECTION)
        .doc(widget.restaurantID)
        .collection(Util.DISHES_COLLECTION)
        .snapshots();
    return stream;
  }

  Future fetchUserDetails() async {
    print("hello dishes");
    String uid = await FirebaseAuth.instance.currentUser!.uid.toString();
    var document = await FirebaseFirestore.instance
        .collection(Util.USERS_COLLECTION)
        .doc(uid)
        .get();
    print("appUser");
    appUser = AppUser();
    // print("Hello $document.get['uid'].toString()");
    // appUser!.uid = document.get('uid').toString();
    // appUser!.name = document.get('name').toString();
    // appUser!.email = document.get('email').toString();
    // appUser!.imageUrl = document.get('imageUrl').toString();

    if (document.exists) {
      // appUser = AppUser();
      print("Hello $document.get['uid'].toString()");
      // appUser!.uid = document.get('uid').toString();
      // appUser!.name = document.get('name').toString();
      // appUser!.email = document.get('email').toString();
      // appUser!.imageUrl = document.get('imageUrl').toString();
      appUser!.isAdmin = document.get('isAdmin');
      print("Successful Data fetched");
    } else {
      print("error");
    }
    return appUser;
  }

  check<Future>() {
    // FirebaseApp secondaryApp = Firebase.app('FoodDelivery');
    User? user = FirebaseAuth.instance.currentUser;
    // firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instanceFor(app: secondaryApp);
    // firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref(user!.uid);
    // print("hi");
    return FutureBuilder(
        future: fetchUserDetails(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            if (appUser!.isAdmin == true) {
              return IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DishesDataPage(
                              restaurantID: widget.restaurantID,
                              restaurantName: widget.restaurantName,
                            )));
                  },
                  icon: Icon(Icons.add));
            } else
            {return Container();}}
          else {
            return Container();
          }});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Util.APP_NAME),
        backgroundColor: Util.APP_COLOR,
        actions: [
          check(),
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, "/cart");
            }, icon: Icon(Icons.shopping_cart),
            tooltip: "Shopping Cart",
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, "/login");
            },
            icon: Icon(Icons.logout),
            tooltip: "Log Out",
          ),
        ],
      ),
      body: StreamBuilder(
          stream: fetchRestaurants(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("SOMETHING WENT WRONG",
                    style: TextStyle(color: Colors.red)),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
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
                children: snapshot.data!.docs
                    .map<Widget>((DocumentSnapshot document) {
              Map<String, dynamic> map =
                  document.data()! as Map<String, dynamic>;
              map['docId'] = document.id.toString();
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                margin: EdgeInsets.all(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.pushNamed(context, "");
                  },
                  child: SingleChildScrollView(
                    child:
                    // Container(
                    //   padding: EdgeInsets.only(
                    //     bottom: 9,
                    //   ),
                    //   margin: EdgeInsets.all(9),
                    //   decoration: BoxDecoration(
                    //       shape: BoxShape.rectangle,
                    //       borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    //       border: Border.all(color: Colors.white)),
                    //   child:
                    Column(
                        children: [
                          Container(
                            height: 250,
                            width: 500,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                color: Colors.black12,
                                image: DecorationImage(
                                    image: NetworkImage(map["imageUrl"]),
                                    fit: BoxFit.fill)),
                          ),

                          Container(
                            margin: EdgeInsets.all(4),
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Column(children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0)),
                                    Text("${map["name"]}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.justify),
                                    Container(

                                      // margin: EdgeInsets.only(right: 4, top: 2, bottom: 0),
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
                                                fontSize: 13),
                                          ),
                                          Icon(
                                              Icons.star,
                                            color: Colors.white,
                                            size: 15,
                                          )
                                        ]
                                      ),
                                    )
                                  ]),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\u20b9 ${map["price"].toString()} for one ",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey),
                                  ),

                                ],
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Text(
                                    discount(map["discount"]["percentageDiscount"],map["discount"]["flatDiscount"]),
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey),
                                  ),

                                  Spacer(),
                                  Container(
                                    width: 100,
                                    height: 35,
                                    child: Counter(dish: map,),
                                  )
                                ],
                              ),

                            ]),
                          ),
                          // Image.network(map["imageUrl"], fit: BoxFit.fill,),
                        ],
                      ),
                    ),
                ),
              );
              // title: Text(map["name"]),
              // subtitle: Text(map['categories']),
            }).toList());
          }),
    );
  }
}
