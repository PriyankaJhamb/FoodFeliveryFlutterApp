import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  CameraPosition place = CameraPosition(
    target: LatLng(30.9024779, 75.8201934),
    zoom: 16,
  );

  Location location = new Location();
  GeoCode geoCode = GeoCode();
  Address? address;


  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  LocationData? _locationData ;

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
      address=addresses;
      locationText = "Latitude: ${_locationData!.latitude} Longitude: ${_locationData!.longitude}";
      place = CameraPosition(
        target: LatLng(_locationData!.latitude!, _locationData!.longitude!),
        zoom: 20,

      );
    });
  }
  void AddAddress(BuildContext context) async{

    UserAddress Address= UserAddress(controllerLabel.text, GeoPoint(_locationData!.latitude!, _locationData!.longitude!), address.toString());
    var dataToSave = Address.toMap();
    Show_Snackbar(context: context, message: "Saving");

    FirebaseFirestore.instance.collection(Util.ADDRESS_COLLECTION).doc().set(dataToSave).then((value) => Navigator.pushReplacementNamed(context, "/useraddress"));
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
              },
              markers: {
              Marker(
              markerId: MarkerId('atpl'),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
              onTap: (){},
              position: LatLng(_locationData!.latitude!=null?_locationData!.latitude!: 30.9024779 ,_locationData!.longitude!=null?_locationData!.longitude!: 75.8201934),
              infoWindow: InfoWindow(
              title: address!.streetAddress!=null?address!.streetAddress: "",
              snippet: address!.countryName!=null?address!.countryName:"",
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
                  TextFormField(
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
                 Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(8),
                   ),
                   child: Column(
                     children: [
                       Text(" Address: ${address!.streetAddress}", textAlign: TextAlign.left,),
                       Text(" City: ${address!.city}", textAlign: TextAlign.left),
                       Text(" State: ${address!.region}", textAlign: TextAlign.left),
                       Text(" Zip Code: ${ address!.postal}", textAlign: TextAlign.left),
                       Text("  Geopoint: "),
                       Text(" Lattitude: ${_locationData!.latitude} Longitude: ${_locationData!.longitude}", textAlign: TextAlign.left),

                     ],
                   ),
                 ),
                 ElevatedButton(
                      onPressed: (){
                        AddAddress(context);
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