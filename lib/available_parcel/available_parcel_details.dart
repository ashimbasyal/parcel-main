import 'package:flutter/material.dart';
import 'package:parcel_sellerapp/available_parcel/available.dart';

class APDetails extends StatefulWidget {
  const APDetails({Key key}) : super(key: key);

  @override
  State<APDetails> createState() => _APDetailsState();
}

class _APDetailsState extends State<APDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Route newRoute =
                  MaterialPageRoute(builder: (context) => AvailableParcel());
              Navigator.pushReplacement(context, newRoute);
            }),
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Details'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
          label: const Text('Update New Address'),
          backgroundColor: Colors.cyan,
          icon: const Icon(
            Icons.add_location,
            color: Colors.white,
          ),
          onPressed: () {}),
    );
  }
}
