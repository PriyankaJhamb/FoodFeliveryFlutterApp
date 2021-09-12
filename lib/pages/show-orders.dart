import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/util/constants.dart';

class ShowOrders extends StatefulWidget {
  const ShowOrders({Key? key}) : super(key: key);

  @override
  _ShowOrdersState createState() => _ShowOrdersState();
}

class _ShowOrdersState extends State<ShowOrders> {

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
            child: DataTable(
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
                rows: <DataRow>[
                  DataRow(
                      cells: <DataCell>[
                        DataCell(Text("Hi")),
                        DataCell(Text("Hi")),
                        DataCell(Text("Hi")),
                        DataCell(Text("Hi")),
                        DataCell(Text("Hi")),
                      ])
                ]),
          )
        ],
      ),
    );
  }
}
