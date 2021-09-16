import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/util/constants.dart';
import 'package:intl/intl.dart';

class ShowOrderMoreInfo extends StatefulWidget {
  Map? map;

  ShowOrderMoreInfo({Key? key,  this.map}) : super(key: key);

  @override
  _ShowOrderMoreInfoState createState() => _ShowOrderMoreInfoState();
}

class _ShowOrderMoreInfoState extends State<ShowOrderMoreInfo> {
  var labeladdress;
  var address;


  @override
  Widget build(BuildContext context) {

    labeladdress=widget.map!=null?widget.map!["address"].split("+")[0]:"";
    address= widget.map!=null?widget.map!["address"].split("+")[1]:"";
    List dishes=widget.map!["dishes"];
    print("HI JJJ: $dishes");
    print("map on more info page: ${widget.map}");
    List widgets=<Widget>[];

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
      body: Card(
        margin: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        elevation: 10,
        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   shape: BoxShape.rectangle,
        //   borderRadius: BorderRadius.circular(10),
        //   border: Border.all(color: Colors.black54, width: 0.5)
        // ),
        child: ListView(

          padding: EdgeInsets.all(18),
          children:[
            Row(
              children: [
                Text(
                  "Order Information",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),


                ),
                Spacer(),
                Text(
                  "ID: ",
                  style: TextStyle(
                    color: Colors.redAccent
                  ),
                ),
                Text(widget.map!=null?widget.map!["id"]:"")
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),

            Text(
                "Delivery To:",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text(
                  "Address Label: ",
                  style: TextStyle(
                      fontWeight: FontWeight.w600
                  ),
                ),
                Spacer(),
                Text("${labeladdress}")
              ],
            ),

            SizedBox(height: 5,),
            Row(
              children: [
                Text(
                  "Address: ",
                  style: TextStyle(
                      fontWeight: FontWeight.w600
                  ),
                ),
                Spacer(),
                Text("${address}")
              ],
            ),
            Divider(),
            Row(

              children: [
                Text(
                  "Order Time: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
                Spacer(),
                Text("${widget.map!=null?DateFormat('dd-MM-yyyy, hh:mm a').format(widget.map!["timestamp"].toDate()).toString():""}"),


                // Text(DateFormat("dd-MM-yyyy").format(widget.map!=null?widget.map!["timestamp"]:"")
                // Text("${widget.map!=null?widget.map!["timestamp"].year.toString():""}/${widget.map!=null?widget.map!["timestamp"].month.toString():""},/${widget.map!=null?widget.map!["timestamp"].day.toString():""}")
              ],
            ),

            SizedBox(height: 10,),
            Divider(),

            Text(
                "Order Items:",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                )
            ),
            //
            // ListView(
            //   children: dishes!=null?dishes.map((){
            //
            //   }),
            // ),

            Text("${widget.map!=null?(widget.map!["dishes"]as List).map((e) => e['imageUrl']).toString():""}"),
            Divider(),



            SizedBox(height: 5,),

            Divider(),


            Row(
              children: [
                Text(
                  "Total: ",
                  style: TextStyle(
                      fontWeight: FontWeight.w600
                  ),
                ),
                Spacer(),
                Text("Rs. ${widget.map!=null?widget.map!["total"]:""}")
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(height: 5,),
            Divider(),

            Row(
              children: [
                Text(
                  "Payment Method",
                  style: TextStyle(
                      fontWeight: FontWeight.w600
                  ),
                ),
                Spacer(),
                Text("${widget.map!=null?widget.map!["address"]:""}")
              ],
            ),
             Text("Total: ${widget.map!=null?widget.map!["total"]:""}"),

          ]
        ),
      )
    );
  }
}
