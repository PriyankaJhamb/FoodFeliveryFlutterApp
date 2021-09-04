import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fooddelivery/custom-widgets/ShowSnackBar.dart';
import 'package:fooddelivery/model/address.dart';
import 'package:fooddelivery/util/constants.dart';
import 'package:geocode/geocode.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
// https://pub.dev/packages/google_maps_flutter

class GoogleMapsPage extends StatefulWidget {
  const GoogleMapsPage({Key? key}) : super(key: key);

  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  TextEditingController controllerLabel=TextEditingController();
  Completer<GoogleMapController> _controller = Completer();
  final FormKey = GlobalKey<FormState>();
  CameraPosition place = CameraPosition(
    target: LatLng(28.9092326, 75.6074934),
    zoom: 16,
  );

  Location location = new Location();
  GeoCode geoCode = GeoCode();
  Address? address;



  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData ;
  GoogleMapController? MyGoogleMapController;

  String locationText = "Location Not Available";

  checkPermissionsAndFetchLocation()async{
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null ;
      }
    }

    _locationData = await location.getLocation();
    var addresses = await geoCode.reverseGeocoding(latitude: _locationData!.latitude as double, longitude: _locationData!.longitude as double);
    setState(() {
      locationText = "Latitude: ${_locationData!.latitude} Longitude: ${_locationData!.longitude}";
      place = CameraPosition(
        target: LatLng(_locationData!.latitude??28.9092326, _locationData!.longitude??75.6074934),
        zoom: 20,
      );
      MyGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(place));
      address=addresses;
    });
  }
  void AddAddress(BuildContext context) async{

    UserAddress Address= UserAddress(controllerLabel.text, GeoPoint(_locationData!.latitude!, _locationData!.longitude!), address!.streetAddress.toString()+", "+address!.region.toString()+", "+address!.countryName.toString()+", "+ address!.postal.toString() );
    var dataToSave = Address.toMap();
    Show_Snackbar(context: context, message: "Saving");

    FirebaseFirestore.instance.collection(Util.USERS_COLLECTION).doc(Util.appUser!.uid).collection(Util.ADDRESS_COLLECTION).doc().set(dataToSave).then((value) => Navigator.pushReplacementNamed(context, "/useraddress"));
    Show_Snackbar(context: context, message: "Saved");
  }
  @override
  Widget build(BuildContext context) {

    checkPermissionsAndFetchLocation();
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
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, "/login");
            },
            icon: Icon(Icons.logout),
            tooltip: "Log Out",
          ),
        ],

      ),
      body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/2,
              child: GoogleMap(
                  initialCameraPosition:place,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    MyGoogleMapController = controller;
                  },
                  markers: {
                    Marker(
                        markerId: MarkerId('atpl'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                        onTap: (){},
                        position: LatLng(_locationData!=null?_locationData!.latitude!: 28.9092326 ,_locationData!=null?_locationData!.longitude!: 75.6074934),
                        infoWindow: InfoWindow(
                          title: address!=null?address!.streetAddress: "",
                          snippet: address!=null?address!.countryName:"",
                          onTap: (){

                          },)
                    )}
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height/2.6 ,
              child: Card(
                margin: EdgeInsets.all((20)),
                child: Column(
                  children: [
                    Divider(),
                    Container(
                      child:  Text(
                        _locationData!=null && address!=null?
                        "Lattitude: ${_locationData!.latitude} \nLongitude: ${_locationData!.longitude},  \n\n Address: ${address!.streetAddress}, ${address!.region}, ${address!.countryName}, ${address!.postal}"
                            :""
                            , textAlign: TextAlign.center),
                      // decoration: BoxDecoration(
                      //   shape: BoxShape.rectangle,
                      //   borderRadius: BorderRadius.circular(10),
                      //   border: Border.all(color: Colors.black54)
                      // ),
                      // child:  Text(" Lattitude: ${_locationData!.latitude??"28.9092326"} \nLongitude: ${_locationData!.longitude??"75.6074934"} \n\n Address: ${address!=null?address!.streetAddress.toString():""}, ${address!=null?address!.region.toString():""}, ${address!=null?address!.countryName.toString():""}, ${address!=null?address!.postal.toString():""}", textAlign: TextAlign.center),
                      ),
                    Divider(),
                    SizedBox(height: 10,),
                    Form(
                      key: FormKey,
                      child: TextFormField(
                        controller:  controllerLabel,

                        style: TextStyle(
                            fontSize: 17.0, color: Colors.grey.shade900),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        autofocus: false,
                        enabled: true,

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Label of the Address is required. Please Enter.';
                          } else if (value.trim().length == 0) {
                            return 'Label of the Address is required. Please Enter.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          alignLabelWithHint: true,
                          labelText: "Label of the Address",
                          labelStyle: TextStyle(color: Colors.green),
                          fillColor: Colors.transparent,

                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                              gapPadding:3.0,
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
                    ),
                    SizedBox(height: 5,),
                    ElevatedButton(
                        onPressed: (){
                          if (FormKey.currentState!.validate()) {
                          AddAddress(context);}
                        },
                        child: Text("Add Address")
                    )
                  ],
                ),
              ),
            )
          ]
      ),
    );
  }
}