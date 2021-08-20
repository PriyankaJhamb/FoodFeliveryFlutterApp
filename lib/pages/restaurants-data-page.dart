import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/model/restaurant.dart';
import 'package:fooddelivery/util/constants.dart';
import 'package:image_picker/image_picker.dart';
class RestaurantsDataPage extends StatefulWidget {
  const RestaurantsDataPage({Key? key}) : super(key: key);

  @override
  _RestaurantsDataPageState createState() => _RestaurantsDataPageState();
}

class _RestaurantsDataPageState extends State<RestaurantsDataPage> {
  String imageUrl="";
  bool choosed=false;
  XFile? image;
  TextEditingController controllerName=TextEditingController();
  TextEditingController controllerCategories=TextEditingController();
  TextEditingController controllerPricePerPerson=TextEditingController();
  TextEditingController controllerRatings=TextEditingController();


  void RegisterRestaurant(BuildContext context) async{

    Restaurant restaurant=Restaurant(imageUrl.toString(), controllerName.text, controllerCategories.text, int.parse(controllerPricePerPerson.text), double.parse(controllerRatings.text));
    var dataToSave = restaurant.toMap();

    FirebaseFirestore.instance.collection("restaurants").doc().set(dataToSave).then((value) => Navigator.pushReplacementNamed(context, "/home"));
  }
  selectedYN(){
    if (choosed)
    {
      return "Selected";
    }
    else
    {
      return "Choose";
    }
  }


  @override
  Widget build(BuildContext context) {


    String imageName = controllerName.text;
    String imagePath="";
    final ImagePicker _picker = ImagePicker();
    Future<void> uploadFile(String filePath) async {
      File file = File(filePath);

      try {
        var dowurl = ( await FirebaseStorage.instance
            .ref('restaurants/'+imageName+'.png')
            .putFile(file)).ref.getDownloadURL();
        print("UPLOAD SUCCESS");
        imageUrl=dowurl.toString();
        print(dowurl);
        print("imageUrl");
        print(imageUrl);
        choosed=true;
      } on FirebaseException catch (e) {
        print("UPLOAD FAILED");
      }
    }



    Future<void> _askedToLead() async {
      return await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            Future.delayed(Duration(seconds: 5), () {
              Navigator.of(context).pop(true);
            });
            return SimpleDialog(
              title: const Text('Select option'),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () async {
                    image = await _picker.pickImage(
                        source: ImageSource.camera);
                   choosed=true;

                  },
                  child: Text('Camera'),
                  padding: EdgeInsets.all(20),
                ),
                SimpleDialogOption(
                  onPressed: () async {
                    image = await _picker.pickImage(
                        source: ImageSource.gallery);
                    choosed=true;

                  },
                  child: Text('Gallery'),
                  padding: EdgeInsets.all(20),


                ),
              ],
            );
          });

    }


    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME),
        backgroundColor: APP_COLOR,
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
                          // Color(0xff4ef100),
                          // Color(0xff03af0f),
                          Colors.white,
                          Colors.white
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
                elevation: 5,
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
                              labelText: "Name of the Restaurant",
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
                            keyboardType: TextInputType.number,
                            // textCapitalization: TextCapitalization.words,
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
                            keyboardType: TextInputType.number,
                            // textCapitalization: TextCapitalization.words,
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
                          SizedBox(
                            height: 6,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    width: 1,
                                    color: Colors.black45
                                )
                            ),
                            padding: EdgeInsets.only(left: 8, right: 8),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Upload Image", style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.green),),
                                Spacer(),
                                ElevatedButton(
                                  onPressed: () async {
                                    // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                                    // uploadFile(image!.path);
                                    _askedToLead();

                                  },
                                  child: Text(selectedYN(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.green),),
                                  style: ElevatedButton.styleFrom(
                                      primary:  Color(0xffeff5e7),
                                      elevation: 5
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            // width: MediaQuery.of(context).size.width,
                            // margin: EdgeInsets.only(top: 10, bottom: 4),
                              child:TextButton(
                                onPressed: (){
                                  setState(() {
                                    imageName = controllerName.text;
                                    print("imageName:$imageName");
                                    uploadFile(image!.path);
                                    RegisterRestaurant(context) ;

                                  });
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: Color(0xff4fa037),
                                    elevation: 15,
                                    padding: EdgeInsets.all(12)
                                  // elevation: 10
                                ),
                                child: Text(
                                  "SUBMIT",
                                  style: TextStyle(
                                      fontSize: 20,
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
