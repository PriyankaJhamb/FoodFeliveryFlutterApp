import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/custom-widgets/counter.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:fooddelivery/pages/razorpay-page.dart';
import 'package:fooddelivery/pages/success.dart';
import 'package:fooddelivery/util/constants.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String paymentMethod = "";
  String labeladdress="";
  var temp = 0;
  Timestamp myTimeStamp = Timestamp.fromDate( DateTime. now());


  fetchDishesInCart() {
    print("fetchDishesInCart");
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance
        .collection(Util.USERS_COLLECTION)
        .doc(Util.appUser!.uid)
        .collection(Util.CART_COLLECTION)
        .snapshots();
    print("stream");
    return stream;
  }

  // dishes List
  var dishes = [];

  placeOrder() {
    Order order = Order(
        dishes: dishes,
        total: temp,
        paymentMethod: paymentMethod,
        address: labeladdress,
        timestamp: myTimeStamp
    );
    var dataToSave = order.toMap();
    // Firebase Insert Operation
    FirebaseFirestore.instance
        .collection(Util.USERS_COLLECTION)
        .doc(Util.appUser!.uid)
        .collection(Util.ORDER_COLLECTION)
        .doc()
        .set(dataToSave)
        .then((value) => Navigator.pushReplacementNamed(context, "/cart"));
  }

  clearCart() {
    print("clearCartdishes: $dishes");
    dishes.forEach((dish) {
      // delete every single dish one by one async :)
     FirebaseFirestore.instance
          .collection(Util.USERS_COLLECTION)
          .doc(Util.appUser!.uid)
          .collection(Util.CART_COLLECTION)
          .doc(dish['docId'])
          .delete();
    });
  }

  navigateToSuccess() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessPage(
              title: "Order Placed",
              message: "Thank You For Placing the Order \u20b9 ${temp}",
              flag: true),
        ));
  }

  @override
  Widget build(BuildContext context) {
    print("Cart Page : ${Util.appUser!.uid}: ${Util.appUser!.uid}");
    Util.total = {};
    total() {
      int total = 0;
      print(Util.total.values);
      Util.total.values.forEach((element) {
        total += element as int;
      });
      temp = total;
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

        if(snapshot.data.docs.isEmpty){
          return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Text(" No Dishes in the Cart yet..."),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                  onPressed: (){
                      Navigator.pushReplacementNamed(context, "/home");
                  },
                  child: Text("Add Dishes"))
                  ],),
          );
        }
        else{
            return ListView(padding: EdgeInsets.all(12), children: [
              Column(
                  children: snapshot.data!.docs
                      .map<Widget>((DocumentSnapshot document) {
                Map<String, dynamic> map =
                    document.data()! as Map<String, dynamic>;
                map['docId'] = document.id.toString();
                Util.total[map["name"]] = map["totalprice"] as int;
                dishes.add(map);

                return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black12)),
                    // margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                                width: 90,
                                height: 80,
                                child: ClipRRect(
                                  child: Image.network(
                                    map["imageUrl"],
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                )),
                          ],
                        ),
                        Expanded(
                          flex: 40,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  map["name"],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.5,
                                      color: Colors.brown),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(children: [
                                  Text(
                                    "₹${map["price"]} per one",
                                    style: TextStyle(fontSize: 13),
                                  )
                                ]),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(children: [
                                Counter(
                                  dish: map,
                                )
                              ]),
                              SizedBox(
                                height: 4,
                              ),
                              Row(children: [
                                Text(" ₹${map["totalprice"].toString()} "),
                                SizedBox(
                                  width: 10,
                                )
                              ])
                            ],
                          ),
                        )
                      ],
                    ));
              }).toList()),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(),
                      total() != 0
                          ? ListTile(
                        title: Text("Total Price"),
                        trailing: Text(" ₹${total().toString()}"),
                      )
                          : Container(),
                      // Divider(),
                      // Container(
                      //   padding: EdgeInsets.all(8),
                      //   // height: 30,
                      //   // decoration: BoxDecoration(
                      //   //   borderRadius: BorderRadius.all(Radius.circular(2))
                      //   //
                      //   // ),
                      //   child: Row(
                      //     children: [
                      //       Text(" Address : "),
                      //       Spacer(),
                      //       InkWell(
                      //           onTap: () async{
                      //             Util.checkpath=true;
                      //             labeladdress= await Navigator.pushNamed(context, "/useraddresses") as String;
                      //             setState((){});
                      //           },
                      //           child: Text(labeladdress!=""?"${labeladdress} ": "Change")
                      //
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // Divider(),
                      // Container(
                      //   padding: EdgeInsets.all(8),
                      //   // height: ,
                      //   child: Row(
                      //     children: [
                      //       Text(" Payment Method : "),
                      //       Spacer(),
                      //       InkWell(
                      //           onTap: () async{
                      //             paymentMethod= await Navigator.pushNamed(context, "/paymentmethods") as String;
                      //             setState((){});
                      //           },
                      //           child: Text(paymentMethod!=""?" ${paymentMethod} ": "Change")
                      //       ),

                      //     ],
                      //   ),
                      // ),
                      // Divider(),
                    ],
                  ),
                ),
              )
            ]);}
          }),
      // bottomNavigationBar: BottomAppBar(
      //   shape: CircularNotchedRectangle(),
      //   // shape: AutomaticNotchedShape(),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //        IconButton(
      //            onPressed: (){},
      //            icon: Icon(Icons.home, color: Colors.black54,)
      //        ),
      //       IconButton(
      //           onPressed: (){},
      //           icon: Icon(Icons.account_box_outlined, color: Colors.black54)
      //       ),
      //     ],
      //   ),
      // ),
      bottomNavigationBar:  Container(
        child: total() != 0?Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(),
            Container(
              padding: EdgeInsets.only(left: 18, right: 18),
              // height: 30,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.all(Radius.circular(2))
              //
              // ),
              child: Row(
                children: [
                  Text(" Address : "),
                  Spacer(),
                  ElevatedButton(
                    // style: ,
                      onPressed: () async{
                        Util.checkpath=true;
                        labeladdress= await Navigator.pushNamed(context, "/useraddresses") as String;
                        setState((){});
                      },
                      child: Text(labeladdress!=""?"${labeladdress} ": "Select")

                  )
                ],
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.only(left: 18, right: 18),
              // height: ,
              child: Row(
                children: [
                  Text(" Payment Method : "),
                  Spacer(),
                  ElevatedButton(
                      onPressed: () async{
                        paymentMethod= await Navigator.pushNamed(context, "/paymentmethods") as String;
                        setState((){});
                      },
                      child: Text(paymentMethod!=""?" ${paymentMethod} ": "Select")
                  ),

                ],
              ),
            ),
            Divider(),
        Container(
            width: 120,
            height: 50,
            padding: EdgeInsets.only(bottom: 10),
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1.0, color: Colors.green, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.green.shade50,
              onPressed: () async {
                myTimeStamp = Timestamp.fromDate( DateTime. now());
                if (total()!=0){
                if(paymentMethod.isNotEmpty){
                int result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RazorPayPaymentPage(amount: temp),
                    ));
                print("result : $result");
                if (result == 1) {
                  // Save the data i.e. Dishes as Order in Orders Collection under User
                  // Order Object -> 1. List of Dishes, 2. Total 3. Address, 4. Restaurant Details
                  placeOrder();
                  // print(dishes);
                  clearCart();
                  print("clear cart");
                  navigateToSuccess();}
                }}
                else
                  {

                  }
              },
              child: Text(
                "PLACE ORDER",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'RobotoMono',
                    color: Colors.green),
                textAlign: TextAlign.center,
              ),
            ),
          ),
            ],
          ): Column(
          mainAxisSize: MainAxisSize.min,
        ),
        ),

      // Container(
      //   padding: EdgeInsets.all(16),
      //   child: Row(
      //     children: [
      //       Column(
      //         children: [
      //           StatefulBuilder(
      //             builder:(context, setState){
      //               return OutlinedButton(
      //                 style: ButtonStyle(
      //                   backgroundColor: MaterialStateProperty.all<Color>(Colors.green.shade50)
      //                 ),
      //                   onPressed: () async{
      //                       paymentMethod= await Navigator.pushNamed(context, "/paymentmethods") as String;
      //                     setState((){});
      //                   },
      //                   child: Text(paymentMethod!=""?"Selected Payment \nMethod: ${paymentMethod} ": "Select Payment")
      //                 //
      //               );
      //             }
      //           )
      //         ],
      //       ),
      //       Spacer(),
      //       Column(
      //         children: [
      //           OutlinedButton(
      //               style: ButtonStyle(
      //                   backgroundColor: MaterialStateProperty.all<Color>(Colors.green.shade50)
      //               ),
      //               onPressed: () async{
      //                 if(paymentMethod.isNotEmpty){
      //
      //                 int result = await Navigator.push(context, MaterialPageRoute(builder: (context) => RazorPayPaymentPage(amount: temp),));
      //
      //                 if(result == 1){
      //                 // Save the data i.e. Dishes as Order in Orders Collection under User
      //                 // Order Object -> 1. List of Dishes, 2. Total 3. Address, 4. Restaurant Details
      //                 // placeOrder();
      //                 // clearCart();
      //                 // navigateToSuccess();
      //                 }}
      //               },
      //               child: Text("PLACE ORDER"))
      //         ],
      //       )
      //     ],
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Container(
      //   width: 120,
      //   height: 50,
      //   padding: EdgeInsets.only(bottom: 10),
      //   child: FloatingActionButton(
      //     shape: RoundedRectangleBorder(
      //         side: BorderSide(
      //             width: 1.0, color: Colors.green, style: BorderStyle.solid),
      //         borderRadius: BorderRadius.circular(10)),
      //     backgroundColor: Colors.green.shade50,
      //     onPressed: () async {
      //       if (total()!=0){
      //       if(paymentMethod.isNotEmpty){
      //       int result = await Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => RazorPayPaymentPage(amount: temp),
      //           ));
      //       print("result : $result");
      //       if (result == 1) {
      //         // Save the data i.e. Dishes as Order in Orders Collection under User
      //         // Order Object -> 1. List of Dishes, 2. Total 3. Address, 4. Restaurant Details
      //         placeOrder();
      //         // print(dishes);
      //         clearCart();
      //         print("clear cart");
      //         navigateToSuccess();}
      //       }}
      //       else
      //         {
      //
      //         }
      //     },
      //     child: Text(
      //       "PLACE ORDER",
      //       style: TextStyle(
      //           fontSize: 14,
      //           fontWeight: FontWeight.w500,
      //           fontFamily: 'RobotoMono',
      //           color: Colors.green),
      //       textAlign: TextAlign.center,
      //     ),
      //   ),
      // ),
    );
  }
}

