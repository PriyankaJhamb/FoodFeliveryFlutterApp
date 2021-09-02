import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/model/dish-model-for-cart.dart';
import 'package:fooddelivery/util/constants.dart';

class Counter extends StatefulWidget {
  Map<String, dynamic>? dish;

  Counter({Key? key, this.dish}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int initialvalue = 0;
  fetchDetailsOfOrderedDishes(){
    print("fetchDishesInCart");
    Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection(Util.USERS_COLLECTION).doc(Util.appUser!.uid).collection(Util.CART_COLLECTION).snapshots();
    print("stream");
    return stream;


  }
  updateDishInCart() {
    DishModelForCartPage cartDish = DishModelForCartPage(
        name: widget.dish!['name'].toString(),
        price: widget.dish!['price'] as int,
        quantity: initialvalue,
        totalprice: initialvalue * (widget.dish!['price'] as int),
        imageUrl: widget.dish!['imageUrl']
    );
    print("ok till here");
    FirebaseFirestore.instance
        .collection(Util.USERS_COLLECTION)
        .doc(Util.appUser!.uid)
        .collection(Util.CART_COLLECTION)
        .doc(widget.dish!['docId']).set(cartDish.toMap());
  }

  deleteDishFromCart() {
    FirebaseFirestore.instance
        .collection(Util.USERS_COLLECTION)
        .doc(Util.appUser!.uid)
        .collection(Util.CART_COLLECTION)
        .doc(widget.dish!['docId']).delete();

  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
      stream: fetchDetailsOfOrderedDishes(),
      builder: (context, AsyncSnapshot snapshot) {
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
        print("DoucmentSnapshot");
        if(snapshot.hasData) {
          print("snapshot.hasData");
          List<DocumentSnapshot> snapshots = snapshot.data!.docs;
          // List<ListTile> tiles = [];
          snapshots.forEach((document) {
            print(document);
            Map<String, dynamic> map = document.data()! as Map<String, dynamic>;
            map['docId'] = document.id.toString();
            print(map["docId"]);
            if (map['docId'] == widget.dish!['docId'].toString()) {
              initialvalue = map['quantity'] as int;
              print(initialvalue);
            }

          });
          // List<DocumentSnapshot> snapshotsdocument =
        //   snapshot.data!.docs.map((DocumentSnapshot document) {
        //     print("document");
        //     Map<String, dynamic> map = document.data()! as Map<String, dynamic>;
        //     map['docId'] = document.id.toString();
        //     print(map["docId"]);
        //     if (map['docId'] == widget.dish!['docId'].toString()) {
        //       initialvalue = map['quantity'] as int;
        //       print(initialvalue);
        //     }
        //     else {
        //       initialvalue = 0;
        //     }
        //   })
        //       // .toList()
        //   ;
        }


        return Container(
          margin: EdgeInsets.only(top: 10, bottom: 10,left: 80, right: 80),

          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.green)),
          child: initialvalue == 0
              ? Container(
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    TextButton(
                      child: Text(
                        "ADD",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown),
                      ),
                      onPressed: () {
                        setState(() {
                          initialvalue++;
                          updateDishInCart();
                        });
                      },
                    )
                  ]),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(primary: Colors.green),
                      onPressed: () {
                        setState(() {
                          // if (initialvalue > 0) {
                          //   initialvalue--;
                          //   updateDishInCart();
                          // } else {
                          //   deleteDishFromCart();
                          //   initialvalue = 0;
                          // }
                         if(initialvalue<0)
                          {
                            initialvalue = 0;
                          }
                          else{
                            initialvalue--;
                            updateDishInCart();
                            if (initialvalue <= 0) {
                              deleteDishFromCart();
                              // dish has to be deleted from cart
                            }
                          }
                        });
                      },
                      // child: Text(
                      //   "-",
                      //   style: TextStyle(
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.black45),
                      // )
                      child: Icon(
                        Icons.remove,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      initialvalue.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (initialvalue < 1000) {
                            initialvalue++;
                            updateDishInCart();
                          }
                        });
                      },
                      // child: Text(
                      //   "+",
                      //   style: TextStyle(
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.black45),
                      // ),
                      child: Icon(
                        Icons.add,
                        color: Colors.green,
                      ),
                      style: TextButton.styleFrom(primary: Colors.green),
                    )
                  ],
                ),
        );
      }
    );
  }
}
