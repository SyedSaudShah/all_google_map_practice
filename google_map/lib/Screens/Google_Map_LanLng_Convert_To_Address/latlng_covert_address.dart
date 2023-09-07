import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LagLngConvertToAddress extends StatefulWidget {
  const LagLngConvertToAddress({super.key});

  @override
  State<LagLngConvertToAddress> createState() => _LagLngConvertToAddressState();
}

class _LagLngConvertToAddressState extends State<LagLngConvertToAddress> {
  String stRing = "", stdAdd = "";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stRing),
          Text(stdAdd),
          Center(
            child: CupertinoButton(
                color: Colors.blueGrey,
                child: const Text("LatLngConvertToAddress"),
                onPressed: () async {
                  List<Location> locations =await locationFromAddress("Gronausestraat 710, Enschede");
                  List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
                  setState(() {
                    stRing =locations.last.latitude.toString()+" "+locations.last.longitude.toString();
                    stdAdd = placemarks.last.country.toString()+"  "+placemarks.last.locality.toString();
                  });
                }),
          ),
        ],
      ),
    );
  }
}
