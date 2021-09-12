import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/db/provider.dart';
import 'package:provider/provider.dart';
import 'package:fooddelivery/util/constants.dart';

class ShowOrders extends StatefulWidget {
  const ShowOrders({Key? key}) : super(key: key);

  @override
  _ShowOrdersState createState() => _ShowOrdersState();
}

class _ShowOrdersState extends State<ShowOrders> {
  var order;
  var list=[];

  fetchOrders(){
    print("order.runtimeType: ${order.runtimeType}");

    print("order.runtimeType: ${order.runtimeType}");
    print("order: ${order}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Util.APP_NAME),
        backgroundColor: Util.APP_COLOR,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, "/cart");
            }, icon: Icon(Icons.shopping_cart),
            tooltip: "Shopping Cart",
          ),

          IconButton(
            onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, "/login");
            }, icon: Icon(Icons.logout),
            tooltip: "Log Out",
          )
        ],
      ),
      body: ListView(
        children: [
          Center(
              heightFactor: 3,
              widthFactor: 5,
              child: Text(" Orders List ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 24, ),)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: context.watch<DataProvider>().orders!=null?DataTable(
                columns: <DataColumn>[
                  DataColumn(
                    label: Text("TimeStamp")
                  ),
                  DataColumn(
                      label: Text("Dishes")
                  ),
                  DataColumn(
                      label: Text("Total")
                  ),
                  DataColumn(
                      label: Text("Payment Method")
                  ),
                  DataColumn(
                      label: Text("Address")
                  ),
                ],
                rows:(context.watch<DataProvider>().orders!).map<DataRow>((DocumentSnapshot document) {
                  list=[];
                  Map<String, dynamic> map=document.data()! as Map<String, dynamic>;
                  print("map ${map["dishes"]} ");

                  map["dishes"].forEach((element) => {
                     list.add(element["name"])
                  });
                  // (map["dishes"])!.map<Map<String, dynamic>>((element){Map<String, dynamic> map1=element.data()! as Map<String, dynamic>; print(map1);list.add(map1["name"]);print(map1["name"]);});
                    return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(map["timestamp"].toDate().toString())),
                          DataCell(Text(list.toString())),
                          DataCell(Text(map["total"].toString())),
                          DataCell(Text(map["paymentMethod"].toString())),
                          DataCell(Text(map["address"])),
                        ]
                    );

                }
                ).toList()


            ):Center(child: Text("Nothing has been ordered yet..")),
          )
        ],
      ),
    );
  }
}
