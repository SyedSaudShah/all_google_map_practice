import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_map/Screens/Google_Map/home_screen.dart';
import 'package:google_map/Screens/Google_Map_LatLng_Current_Address_With_Permission/current_position_in_permission.dart';
import 'package:google_map/Screens/Places.dart';

import 'Screens/Google_Map_LanLng_Convert_To_Address/latlng_covert_address.dart';

void main() {
  runApp(const GoogleMap());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

class GoogleMap extends StatelessWidget {
  const GoogleMap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Map .',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PlacesFetchWidget(),
    );
  }
}
