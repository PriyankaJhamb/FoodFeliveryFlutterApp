import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/util/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class UserAddressesPage extends StatefulWidget {
  const UserAddressesPage({Key? key}) : super(key: key);

  @override
  _UserAddressesPageState createState() => _UserAddressesPageState();
}

class _UserAddressesPageState extends State<UserAddressesPage> {
  fetchDetailsOfAddresses() {
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection(Util.USERS_COLLECTION)
        .doc(Util.appUser!.uid)
        .collection(Util.ADDRESS_COLLECTION)
        .snapshots();
    print("stream");
    return stream;
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Util.APP_NAME),
        backgroundColor: Util.APP_COLOR,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/cart");
            },
            icon: Icon(Icons.shopping_cart),
            tooltip: "Shopping Cart",
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, "/login");
            },
            icon: Icon(Icons.logout),
            tooltip: "Log Out",
          )
        ],
      ),
      body: StreamBuilder(
          stream: fetchDetailsOfAddresses(),
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
            if (snapshot.data.docs.isEmpty)
              {
                return Center(
                  child: Text("Click on FAB to add address"),
                );
              }

            print("snapshot.hasData");

              return ListView(
                  children: snapshot.data!.docs
                      .map<Widget>((DocumentSnapshot document) {
                Map<String, dynamic> map =
                    document.data()! as Map<String, dynamic>;
                map['docId'] = document.id.toString();
                return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "");
                    },
                    child: ListTile(
                      title: Text(map["label"]),
                      subtitle: Text(map["geopoint"]),
                    ));
                // title: Text(map["name"]),
                // subtitle: Text(map['categories']),
              }).toList());


            print("Center");

          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         Navigator.pushNamed(context, '/googlemap');
        },
        backgroundColor: Colors.green,
        child: Icon(
          Icons.gps_fixed,
          color: Colors.white,
        ),
      ),
    );
  }
}
