import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/util/constants.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({Key? key}) : super(key: key);

  @override
  _PaymentMethodsPageState createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  fetchPaymentMethods(){
    Stream<QuerySnapshot> stream= FirebaseFirestore.instance.collection(Util.EXTRAS_COLLECTION).doc("payment-methods").collection(Util.PAYMENTMETHODS_COLLECTION).snapshots();
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
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, "/login");
            },
            icon: Icon(Icons.logout),
            tooltip: "Log Out",
          ),
        ],
      ),
      body: StreamBuilder(
        stream: fetchPaymentMethods(),
        builder: (context, AsyncSnapshot snapshot){
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
                return ListTile(
                  title:Text(map["name"]),
                  onTap: (){
                    Navigator.pop(context,map["name"]);
                  },
                );
              }).toList());
        },
      ),
    );
  }
}
