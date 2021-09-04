import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery/custom-widgets/ShowSnackBar.dart';
import 'package:fooddelivery/model/dish.dart';
import 'package:fooddelivery/util/constants.dart';
import 'package:image_picker/image_picker.dart';


class DishesDataPage extends StatefulWidget {
  String? restaurantID;
  String? restaurantName;


  DishesDataPage({Key? key, this.restaurantID, this.restaurantName}) : super(key: key);
  @override
  _DishesDataPageState createState() => _DishesDataPageState();
}

class _DishesDataPageState extends State<DishesDataPage> {
  String dowurl="";
  XFile? image;
  final dishesFormKey = GlobalKey<FormState>();
   toMapDiscount()=>{
       "flatDiscount":int.parse(controllerFLatDiscount.text),
       "percentageDiscount":int.parse(controllerPercentageDiscount.text)
   };


  void RegisterDish(BuildContext context, url) async{

    Dish dish=Dish(url, controllerName.text, toMapDiscount() , int.parse(controllerPrice.text), double.parse(controllerRatings.text));
    var dataToSave = dish.toMap();
    print(dataToSave);
    Show_Snackbar(context: context, message: "Saving");
    FirebaseFirestore.instance.collection(Util.RESTAURANT_COLLECTION).doc(widget.restaurantID).collection(Util.DISHES_COLLECTION).doc().set(dataToSave).then((value) => Navigator.pushReplacementNamed(context, "/dishdata"));
    Show_Snackbar(context: context, message: "Saved");
    print("Done");
  }

  TextEditingController controllerName=TextEditingController();
  TextEditingController controllerFLatDiscount=TextEditingController();
  TextEditingController controllerPercentageDiscount=TextEditingController();
  TextEditingController controllerPrice=TextEditingController();
  TextEditingController controllerRatings=TextEditingController();
   bool choosed=false;

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
    uploadFile(String filePath) async {
      File file = File(filePath);

      try {
        Show_Snackbar(message: "Uploading", context: context);
        var temp= await FirebaseStorage.instance
            .ref('dishes/'+imageName+'.png')
            .putFile(file);
        Show_Snackbar(message: "Uploaded", context: context);
        dowurl = await temp.ref.getDownloadURL();
        return dowurl;
        print(dowurl.toString());
        print("UPLOAD SUCCESS");
      } on FirebaseException catch (e) {
        print("UPLOAD FAILED");
      }
    }

    Future<void> _askedToLead() async {
      return showDialog<void>(
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
                    padding: EdgeInsets.all(20)
                ),
                SimpleDialogOption(
                    onPressed: () async {
                      image = await _picker.pickImage(
                          source: ImageSource.gallery);
                      choosed=true;

                    },
                    child: Text('Gallery'),
                    padding: EdgeInsets.all(20)


                ),
              ],
            );
          });

    }



    return Scaffold(
      appBar: AppBar(
        title: Text(Util.APP_NAME),
        backgroundColor: Util.APP_COLOR,
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
                elevation: 10,
                margin: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Container(
                    // height: MediaQuery.of(context).size.height/2,
                    // width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(16),
                    child: Form(
                      key: dishesFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset("assets/icon.png", fit:BoxFit.fill),
                          SizedBox(height: 4,),
                          Text("Add Dish in the { ${widget.restaurantName} } Dishes List", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w500),),
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
                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.words,
                            autofocus: false,
                            enabled: true,
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return "Flat Discount is required. Please Enter.";
                              }
                              else if(value.trim().length==0)
                              {
                                return "Flat Discount is required. Please Enter.";
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
                                contentPadding: EdgeInsets.only(left: 8)
                            ),
                          ),
                          SizedBox(height: 4,),
                          TextFormField(
                            controller: controllerPercentageDiscount,
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.grey.shade900),
                            keyboardType: TextInputType.number,
                            autofocus: false,
                            enabled: true,
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return "Percentage Discount is required. Please Enter.";
                              }
                              else if(value.trim().length==0)
                              {
                                return "Percentage Discount is required. Please Enter.";
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
                            keyboardType: TextInputType.number,
                            //textCapitalization: TextCapitalization.words,
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
                                      _askedToLead();
                                    // uploadFile(image!.path);

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

                                  setState(() async {
                                    if (dishesFormKey.currentState!.validate()) {
                                    imageName = controllerName.text;
                                    print("imageName:$imageName");
                                    var url = await uploadFile(image!.path);
                                    RegisterDish(context,url) ;}

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
