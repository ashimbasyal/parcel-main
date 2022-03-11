import 'package:flutter/material.dart';
import 'package:parcel_sellerapp/homepage/home.dart';

class AvailableParcel extends StatefulWidget {
  const AvailableParcel({ Key key }) : super(key: key);

  @override
  State<AvailableParcel> createState() => _AvailableParcelState();
}

class _AvailableParcelState extends State<AvailableParcel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Route newRoute =
                  MaterialPageRoute(builder: (context) => HomePage());
              Navigator.pushReplacement(context, newRoute);
            }),
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Available'),
        centerTitle: true,
      ),
    );
  }
}