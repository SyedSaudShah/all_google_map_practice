import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CurrentAddressWithPermission extends StatefulWidget {
  const CurrentAddressWithPermission({super.key});

  @override
  State<CurrentAddressWithPermission> createState() =>
      _CurrentAddressWithPermissionState();
}

class _CurrentAddressWithPermissionState
    extends State<CurrentAddressWithPermission> {
  LocationPermission? permission;
  Position? position;
  void geoLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission permissionDialog =
          await Geolocator.requestPermission();
      print(permission);
    } else {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      print("Latitude : ${position!.latitude.toString()}" +
          "\n " +
          "Longitude : ${position!.longitude.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
                  "${position?.latitude.toString()}",
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
          Text(position!.latitude.toString(),style:const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          Center(
            child: CupertinoButton(
                color: Colors.blueGrey,
                child: const Text("LatLngConvertToAddress"),
                onPressed: () {
                  geoLocation();
                }),
          ),
        ],
      ),
    );
  }
}
