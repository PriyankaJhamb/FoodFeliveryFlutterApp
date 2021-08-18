import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/model/restaurant.dart';
class RestaurantsDataPage extends StatefulWidget {
  const RestaurantsDataPage({Key? key}) : super(key: key);

  @override
  _RestaurantsDataPageState createState() => _RestaurantsDataPageState();
}

class _RestaurantsDataPageState extends State<RestaurantsDataPage> {

  void RegisterRestaurant(BuildContext context) async{
      Restaurant restaurant=Restaurant(controllerIU.text, controllerName.text, controllerCategories.text, int.parse(controllerPricePerPerson.text), double.parse(controllerRatings.text));
      var dataToSave = restaurant.toMap();

      FirebaseFirestore.instance.collection("restaurants").doc().set(dataToSave).then((value) => Navigator.pushReplacementNamed(context, "/home"));
  }
  TextEditingController controllerIU=TextEditingController();
  TextEditingController controllerName=TextEditingController();
  TextEditingController controllerCategories=TextEditingController();
  TextEditingController controllerPricePerPerson=TextEditingController();
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
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(16),
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("assets/icon.png", fit:BoxFit.fill),
                        SizedBox(height: 4,),
                        Text("Enter the details of Restaurant to add in the restaurant list", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w500),),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller:  controllerName,
                          style: TextStyle(
                              fontSize: 17.0, color: Colors.grey.shade900),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          autofocus: false,
                          enabled: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name of the Restaurant is required. Please Enter.';
                            } else if (value.trim().length == 0) {
                              return 'Name of the Restaurant is required. Please Enter.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            alignLabelWithHint: true,
                            labelText: "Login ID",
                            labelStyle: TextStyle(color: Colors.green),
                            fillColor: Colors.transparent,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: Colors.black)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: Colors.red)),
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: Colors.grey)),
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: Colors.grey)),
                            contentPadding:
                            new EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                          ),
                        ),
                        SizedBox(height: 8,),
                        TextFormField(
                          controller: controllerCategories,
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.grey.shade900),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          autofocus: false,
                          enabled: true,
                          validator: (value){
                            if(value!.isEmpty)
                            {
                              return "Categories are required. Please Enter.";
                            }
                            else if(value.trim().length==0)
                            {
                              return "Categories are required. Please Enter.";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              filled: true,
                              alignLabelWithHint: true,
                              labelText: "Categories",
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
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                      width: 1
                                  )
                              ),

                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(
                                      color: Colors.red,
                                      style: BorderStyle.solid,
                                      width: 1
                                  )
                              ),

                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                  borderSide: BorderSide(
                                      color: Colors.black87,
                                      style: BorderStyle.solid,
                                      width: 1
                                  )
                              ),
                              contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0,0.0)
                          ),
                        ),
                        SizedBox(height: 8,),
                        TextFormField(
                          controller: controllerPricePerPerson,
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.grey.shade900),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          autofocus: false,
                          enabled: true,
                          validator: (value){
                            if(value!.isEmpty)
                            {
                              return "Price Per Person is required. Please Enter.";
                            }
                            else if(value.trim().length==0)
                            {
                              return "Price Per Person is required. Please Enter.";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              filled: true,
                              alignLabelWithHint: true,
                              labelText: "Price Per Person",
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
                        SizedBox(height: 8,),
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
                                RegisterRestaurant(context);
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
