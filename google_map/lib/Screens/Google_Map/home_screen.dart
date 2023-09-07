import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _completer = Completer<GoogleMapController>();

  // ** Camera Position show this google map Directions .
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(29.802813, 71.739063),
    zoom: 18.4746,
  );

  // ** Multiple Marker show in current location in google map .
  List<Marker> marker = [];
  List<Marker> list = const [
    // ** Rehman $ Co Location
    Marker(markerId: MarkerId("1"),
        position: LatLng(29.802813, 71.739063),
        infoWindow: InfoWindow(
            title: "Rehman & Co",
            snippet: "Dunyapur, Lodhran, PunjabPakistan")),
    // ** Apna Group Of Companies
    Marker(
        markerId: MarkerId("2"),
        position: LatLng(29.802813, 71.739172),
        infoWindow: InfoWindow(
            title: "Apna Group Of Companies",
            snippet: "Main Tanki Wali Gali Dunyapur, Lodhran, PunjabPakistan")),
    // ** CAS SOFTWARE HOUSE
    Marker( markerId: MarkerId("3"),
        position: LatLng(29.802862, 71.738922),
        infoWindow: InfoWindow(
            title: "Irfan Sanitary Maple Leaf Cement Agency",
            snippet: "Dunya Pur"),),
    Marker(markerId: MarkerId("4"),
    position: LatLng(29.383063, 71.715437),
    infoWindow: InfoWindow(title: "CAS",snippet: "Software House"))        
  ];

  @override
  void initState() {
    super.initState();
    marker.addAll(list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.satellite,
        markers: Set<Marker>.of(marker),
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _completer.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          GoogleMapController controller = await _completer.future;
           controller.animateCamera(CameraUpdate.newCameraPosition(
              const CameraPosition(target: LatLng(29.383063, 71.715437),zoom: 19)));
              // setState(() {});
        },
        child: const Icon(Icons.location_searching_sharp,color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
