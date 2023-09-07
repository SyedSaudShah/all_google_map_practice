import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
              // Todo : Google Map Using Permission in flutter .
void main(List<String> args) {
  runApp(const CurrentLocation());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

class CurrentLocation extends StatelessWidget {
  const CurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.cyan),
        home: const LocationAndMarker());
  }
}

class LocationAndMarker extends StatefulWidget {
  const LocationAndMarker({super.key});

  @override
  State<LocationAndMarker> createState() => _LocationAndMarkerState();
}

class _LocationAndMarkerState extends State<LocationAndMarker> {
  final Completer<GoogleMapController> completer = Completer();

  CameraPosition kCameraPosition = const CameraPosition(
      target: LatLng(29.354350, 71.691066), zoom: 16.687667);

  List<Marker> addMarker = <Marker>[];
  List<Marker> marker = [
    const Marker(
        markerId: MarkerId("1"),
        position: LatLng(29.354350, 71.691066),
        infoWindow: InfoWindow(title: "Dunya Pur Railway Road")),
  ];

  // * Current Position in User.

  Future<Position> getCurrentPosition() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("Error   $error");
    });

    return await Geolocator.getCurrentPosition();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   addMarker = marker;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        // cameraTargetBounds: CameraTargetBounds(LatLngBounds(northeast: LatLng(29.802813, 71.739063),southwest: LatLng(29.383063, 71.715437))),
        initialCameraPosition: kCameraPosition,
        mapType: MapType.hybrid,
        myLocationEnabled: true,
        markers: Set<Marker>.of(marker),
        onMapCreated: (GoogleMapController controller) {
          completer.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getCurrentPosition().then((value) async{
            print("Current Location");
            print("${value.latitude.toString()}\n ${value.longitude.toString()}");
            /// *(CameraPosition) hm na ak to apny Map ko initial de ha aur dosre hm na
            /// *asy latLng() bhi pass kryaya.
            /// Aur nachy hm na ya malom kya ha ka User Ki Current Location kya ha
            /// aur aur jb hm na user ki current location define kr le tb hmy apna 
            /// camera ko update bhi krwana ha ko apna current place pr jo camera ha
            /// wo User ki current place pr chala jaya .

          CameraPosition cameraPosition = CameraPosition(target: LatLng(value.latitude, value.longitude),zoom: 20);
            GoogleMapController googleController = await completer.future;
            googleController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition),);
          }).onError((error, stackTrace){
            
          });

        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
