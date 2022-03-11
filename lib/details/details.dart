// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:parcel_sellerapp/address/address_mode.dart';
// import 'package:parcel_sellerapp/details/degin.dart';
// import 'package:parcel_sellerapp/homepage/home.dart';
// import 'package:parcel_sellerapp/pickup.dart';


// class Details extends StatefulWidget {
//   var id;

//   final formKey = GlobalKey<FormState>();
//   final String documentId;

//   Details({this.documentId});

//   @override
//   _DetailsState createState() => _DetailsState();
// }

// class _DetailsState extends State<Details> {
//   String orderStatus = "";
//   var data;
//   bool _isInit = true;
//   Future dtails;

//   @override
//   void didChangeDependencies() {
//     // todo

//     super.didChangeDependencies();

//     if (_isInit) {
//       dtails = FirebaseFirestore.instance
//           .collection('users')
//           .doc(widget.documentId)
//           .get()
//           .then((DocumentSnapshot documentSnapshot) {
//         data = documentSnapshot.data();
//         print(documentSnapshot.data());
//       });
//     }
//     _isInit = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final ord = widget.documentId;
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () {
//               Route newRoute =
//                   MaterialPageRoute(builder: (context) => HomePage());
//               Navigator.pushReplacement(context, newRoute);
//             }),
//         iconTheme: const IconThemeData(color: Colors.black),
//         title: const Text('Shipping Details:'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Center(
//                   child: Text(
//                     "Order Id : $ord",
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const Padding(padding: EdgeInsets.all(8)),
//             const Divider(
//               thickness: 4,
//             ),
//             const Padding(padding: EdgeInsets.all(8)),
//             Image.network(
//                 "https://thumbs.dreamstime.com/b/delivery-man-riding-scooter-motorcycle-blue-parcel-box-back-food-service-fast-shipping-cartoon-vector-illustration-186330602.jpg"),
//             const Divider(
//               thickness: 4,
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             FutureBuilder(
//                 future: dtails,
//                 builder: (BuildContext context, AsyncSnapshot snapshot) {
//                   return snapshot.connectionState == ConnectionState.waiting
//                       ? const Center(child: CircularProgressIndicator())
//                       : DetailsDesign(
//                           model: Address.fromJson(data),
//                         );
//                 }),
//             const SizedBox(
//               height: 10,
//             ),
//             ElevatedButton(
//               child: const Text('Order Delivered'),
//               onPressed: () {
//                 Route newRoute =
//                     MaterialPageRoute(builder: (context) => PickupLocation());
//                 Navigator.pushReplacement(context, newRoute);
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
