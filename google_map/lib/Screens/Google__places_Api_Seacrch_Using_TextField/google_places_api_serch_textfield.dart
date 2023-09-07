// // // * Google Map Api key   =>   AIzaSyBDAFlG43XquxYaozLjaOV9UwilYH9RpAg

// // import 'dart:async';

// // import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:uuid/uuid.dart';

// // void main(List<String> args) {
// //   runApp(MaterialApp(
// //     debugShowCheckedModeBanner: false,
// //     theme: ThemeData(
// //       primarySwatch: Colors.green,
// //     ),
// //     home: const PlacesApiWithTextField(),
// //   ));
// // }

// // class PlacesApiWithTextField extends StatefulWidget {
// //   const PlacesApiWithTextField({super.key});

// //   @override
// //   State<PlacesApiWithTextField> createState() => _PlacesApiWithTextFieldState();
// // }

// // class _PlacesApiWithTextFieldState extends State<PlacesApiWithTextField> {
// //   TextEditingController editingController = TextEditingController();
// //   Uuid uuid = const Uuid();
// //   String sessionToken = "1234567";



// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     editingController = TextEditingController();

// //     editingController.addListener(() {
// //       setState(() {
// //         change();
// //       });
// //     });
// //   }


// //   void change() {
// //     if (sessionToken == null) {
// //       sessionToken = uuid.v4();
// //     }
// //   }
// //   @override
// //   void dispose() {
// //     // TODO: implement dispose
// //     super.dispose();
// //     editingController.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: TextField(
// //         controller: editingController,
// //         decoration: InputDecoration(
// //           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
// //         ),
// //       ),
// //     );
// //   }
// // }



// // ignore_for_file: non_constant_identifier_names

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';
// import 'package:http/http.dart' as http;


// void main(List<String> args) {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     theme: ThemeData(
//       primarySwatch: Colors.green,
//     ),
//     home:  GoogleSearchPlacesApi(),
//   ));
// }
// class GoogleSearchPlacesApi extends StatefulWidget {

//   @override
//   _GoogleSearchPlacesApiState createState() => _GoogleSearchPlacesApiState();
// }

// class _GoogleSearchPlacesApiState extends State<GoogleSearchPlacesApi> {


//   TextEditingController _controller = TextEditingController();
//   var uuid = const Uuid();
//   String _sessionToken = '1234567890';
//   List<dynamic> _placeList = [];

//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(() {
//       _onChanged();
//     });
//   }

//   _onChanged() {
//     if (_sessionToken == null) {
//       setState(() {
//         _sessionToken = uuid.v4();
//       });
//     }
//     getSuggestion(_controller.text);
//   }

//   void getSuggestion(String input) async {


//     String kPLACES_API_KEY = " AIzaSyBDAFlG43XquxYaozLjaOV9UwilYH9RpAg";
//     // String type = '(regions)';

//     try{
//       String baseURL =
//           'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//       String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
//       var response = await http.get(Uri.parse(request));
//       print(response.body);
//       var data = json.decode(response.body);
//       print('mydata');
//       print(data);
//       if (response.statusCode == 200) {
//         print(response.statusCode);
//         setState(() {
//           _placeList = json.decode(response.body)['predictions'];
//         });
//       } else {
//         throw Exception('Failed to load predictions');
//       }
//     }catch(e){
//      // toastMessage('success');
//     }

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: Text('Google Map Search places Api' ,),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Align(
//             alignment: Alignment.topCenter,
//             child: TextField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 hintText: "Seek your location here",
//                 focusColor: Colors.white,
//                 floatingLabelBehavior: FloatingLabelBehavior.never,
//                 prefixIcon: Icon(Icons.map),
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.cancel), onPressed: () {
//                   _controller.clear() ;
//                 },
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: _placeList.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () async { },
//                   child: ListTile(
//                     title: Text(_placeList[index]["description"]),
//                   ),
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
//  }