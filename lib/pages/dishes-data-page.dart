import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/model/dish.dart';
import 'package:fooddelivery/model/restaurant.dart';
import 'package:fooddelivery/util/constants.dart';
class DishesDataPage extends StatefulWidget {
  String? restaurantID;
  DishesDataPage({Key? key, this.restaurantID}) : super(key: key);

  @override
  _DishesDataPageState createState() => _DishesDataPageState();
}

class _DishesDataPageState extends State<DishesDataPage> {
   toMapDiscount()=>{
       "flatDiscount":controllerFLatDiscount.text,
       "percentageDiscount":controllerPercentageDiscount.text
   };

  void RegisterDish(BuildContext context) async{
    Dish dish=Dish(controllerIU.text, controllerName.text, toMapDiscount() , int.parse(controllerPrice.text), double.parse(controllerRatings.text));
    var dataToSave = dish.toMap();
    FirebaseFirestore.instance.collection(RESTAURANT_COLLECTION).doc(widget.restaurantID).collection(DISHES_COLLECTION).doc().set(dataToSave).then((value) => Navigator.pushReplacementNamed(context, "/home"));
  }
  TextEditingController controllerIU=TextEditingController();
  TextEditingController controllerName=TextEditingController();
  TextEditingController controllerFLatDiscount=TextEditingController();
  TextEditingController controllerPercentageDiscount=TextEditingController();
  TextEditingController controllerPrice=TextEditingController();
  TextEditingController controllerRatings=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loving Food"),
        backgroundColor: Colors.yellow,
        actions: [
          IconButton(
            onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, "/login");
            }, icon: Icon(Icons.logout),
            tooltip: "Log Out",

          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: <Color>[
                          Color(0xff4ef100),
                          Color(0xff03af0f),
                        ],
                        tileMode:
                        TileMode.clamp, // repeats the gradient over the canvas
                      ),
                    )),
              ),
              Container(

                height: MediaQuery.of(context).size.height/2,
                color: Colors.white,
              )
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Card(
                margin: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Container(
                    // height: MediaQuery.of(context).size.height/2,
                    // width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(16),
                    child: Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset("assets/icon.png", fit:BoxFit.fill),
                          SizedBox(height: 4,),
                          Text("Enter the details of Dish to add in the Dishes list", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w500),),
                          SizedBox(height: 10,),
                          TextFormField(
                            controller:controllerName,
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.grey.shade900),
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            autofocus: false,
                            enabled: true,
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return "Dish Name is required. Please Enter.";
                              }
                              else if(value.trim().length==0)
                              {
                                return "Dish Name is required. Please Enter.";
                              }
                              // return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                alignLabelWithHint: true,
                                labelText: "Name of the Dish",
                                labelStyle: TextStyle(color: Colors.green),
                                fillColor: Colors.transparent,

                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                        width: 1
                                    )
                                ),

                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                        width: 1
                                    )
                                ),

                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.red,
                                        style: BorderStyle.solid,
                                        width: 1
                                    )
                                ),

                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.black87,
                                        style: BorderStyle.solid,
                                        width: 1
                                    )
                                ),
                                contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0,0.0)
                            ),

                          ),
                          SizedBox(height: 4,),
                          TextFormField(
                            controller: controllerFLatDiscount,
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.grey.shade900),
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            autofocus: false,
                            enabled: true,
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return "Flat Discount are required. Please Enter.";
                              }
                              else if(value.trim().length==0)
                              {
                                return "Flat Discount are required. Please Enter.";
                              }
                              // return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                alignLabelWithHint: true,
                                labelText: "Flat Discount",
                                labelStyle: TextStyle(color: Colors.green),
                                fillColor: Colors.transparent,

                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                        width: 1
                                    )
                                ),

                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                        width: 1
                                    )
                                ),

                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.red,
                                        style: BorderStyle.solid,
                                        width: 1
                                    )
                                ),

                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.black87,
                                        style: BorderStyle.solid,
                                        width: 1
                                    )
                                ),
                                contentPadding: EdgeInsets.all(0)
                            ),
                          ),
                          SizedBox(height: 4,),
                          TextFormField(
                            controller: controllerPercentageDiscount,
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.grey.shade900),
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            autofocus: false,
                            enabled: true,
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return "Percentage Discount are required. Please Enter.";
                              }
                              else if(value.trim().length==0)
                              {
                                return "Percentage Discount are required. Please Enter.";
                              }
                              // return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                alignLabelWithHint: true,
                                labelText: "Percentage Discount",
                                labelStyle: TextStyle(color: Colors.green),
                                fillColor: Colors.transparent,

                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                        width: 1
                                    )
                                ),

                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                        width: 1
                                    )
                                ),

                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.red,
                                        style: BorderStyle.solid,
                                        width: 1
                                    )
                                ),

                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.black87,
                                        style: BorderStyle.solid,
                                        width: 1
                                    )
                                ),
                                contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0,0.0)
                            ),
                          ),
                          SizedBox(height: 4,),
                          TextFormField(
                            controller: controllerPrice,
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.grey.shade900),
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            autofocus: false,
                            enabled: true,
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return "Price is required. Please Enter.";
                              }
                              else if(value.trim().length==0)
                              {
                                return "Price is required. Please Enter.";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                alignLabelWithHint: true,
                                labelText: "Price",
                                labelStyle: TextStyle(color: Colors.green),
                                fillColor: Colors.transparent,

                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                        width: 1
                                    )
                                ),

                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                        width: 1
                                    )
                                ),

                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.red,
                                        style: BorderStyle.solid,
                                        width: 1
                                    )
                                ),

                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.black87,
                                        style: BorderStyle.solid,
                                        width: 1
                                    )
                                ),
                                contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0,0.0)
                            ),
                          ),
                          SizedBox(height: 4,),
                          TextFormField(
                            controller: controllerRatings,
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.grey.shade900),
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            autofocus: false,
                            enabled: true,
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return "Ratings is required. Please Enter.";
                              }
                              else if(value.trim().length==0)
                              {
                                return "Ratings is required. Please Enter.";
                              }
                              // return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                alignLabelWithHint: true,
                                labelText: "Ratings",
                                labelStyle: TextStyle(color: Colors.green),
                                fillColor: Colors.transparent,

                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                        width: 1
                                    )
                                ),

                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        style: BorderStyle.solid,
                                        width: 1
                                    )
                                ),

                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: Colors.red,
                                        style: BorderStyle.solid,
                                        width: 1
                                    )
                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                      color: Colors.black87,
                                      style: BorderStyle.solid,
                                      width: 1
                                  ),
                                ),
                                border: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    borderSide: BorderSide(
                                        width: 1,
                                        style: BorderStyle.solid,
                                        color: Colors.grey)),
                                contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0)
                            ),
                          ),
                          Container(
                            // width: MediaQuery.of(context).size.width,
                            // margin: EdgeInsets.only(top: 10, bottom: 4),
                              child:TextButton(
                                onPressed: (){
                                  setState(() {
                                    RegisterDish(context);
                                  });
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  // elevation: 10
                                ),
                                child: Text(
                                  "SUBMIT",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                              )

                          )

                        ],
                      ),
                    ),
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}
