import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/custom-widgets/counter.dart';
import 'package:fooddelivery/util/constants.dart';

class CartPage extends StatefulWidget {

  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {


  fetchDishesInCart(){
    print("fetchDishesInCart");
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection(Util.USERS_COLLECTION).doc(Util.appUser!.uid).collection(Util.CART_COLLECTION).snapshots();
    print("stream");
    return stream;
  }
  @override
  Widget build(BuildContext context) {

    Util.total={};
    total(){
      int total=0;
      print(Util.total.values);
      Util.total.values.forEach((element) {
        total+=element as int;
      });

      return total;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(Util.APP_NAME),
        backgroundColor: Util.APP_COLOR,
        actions: [

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
          stream: fetchDishesInCart(),
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
              children: [Column(
                  children: snapshot.data!.docs
                      .map<Widget>((DocumentSnapshot document) {
                    Map<String, dynamic> map = document.data()! as Map<String, dynamic>;
                    map['docId'] = document.id.toString();
                    Util.total[map["name"]]=map["totalprice"] as int;
                    return Column(
                      children: [
                        ListTile(
                          leading:Image.network(map["imageUrl"]),
                          title: Text(map["name"]),
                          subtitle: Text(" ${map["quantity"].toString()} * ₹${map["price"]}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("="),

                              Text(" ₹${map["totalprice"].toString()} ")

                            ],
                          ),
                        ),
                        Counter(dish: map,)
                      ],
                    );
                  }).toList()
              ),
                Divider(),
                total()!=0?
                ListTile(
                  title: Text("Total Price"),
                  trailing: Text(" ₹${total().toString()}"),
                ):
                    Container()

            ]);
          }),
    );
  }
}
