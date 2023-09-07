import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
    home: const ChangeLayoutMap(),
  ));
}

class ChangeLayoutMap extends StatefulWidget {
  const ChangeLayoutMap({super.key});

  @override
  State<ChangeLayoutMap> createState() => _ChangeLayoutMapState();
}

class _ChangeLayoutMapState extends State<ChangeLayoutMap> {
  final Completer<GoogleMapController> _completer = Completer();
  static const LatLng _center = LatLng(45.521563, -122.677433);
  final Set<Marker> _markers = {};

  addThisMarker() {
    setState(() {
      _markers.add(const Marker(
        markerId: MarkerId("1"),
        position: _center,
        infoWindow: InfoWindow(
          title: "Really Cool Place",
          snippet: "10 Star Rating This Place",
        ),
      ));
    });
  }


//  Map Type.
  MapType mapType = MapType.hybrid;
// Map Type Method And using feature map layout changing process.
  changeMapType() {
    setState(() {
      if (mapType == MapType.hybrid) {
        mapType = MapType.normal;
        print(mapType);
      } else if (mapType == MapType.normal) {
        mapType = MapType.satellite;
        print(mapType);
      } else if (mapType == MapType.satellite){
        mapType = MapType.terrain;
        print(mapType);
      }else{
        mapType = MapType.normal;
      }
    });
  }

  // New Map Create and Update this camera location.
  onMapCreate(GoogleMapController controller) {
    _completer.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      GoogleMap(
        initialCameraPosition: const CameraPosition(target: _center, zoom: 17),
        mapType: mapType,
        markers: _markers,
        onMapCreated: onMapCreate,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 50, right: 5),
        child: Align(
            alignment: Alignment.topRight,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    changeMapType();
                  },
                  child: const Icon(
                    Icons.map,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10,),
                FloatingActionButton(onPressed: () {
                  addThisMarker();
                },child: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),)
              ],
            )),
      ),
    ]));
  }
}
