import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parcel_sellerapp/address/saveaddress_screen.dart';
import 'package:parcel_sellerapp/cart/cart.dart';
import 'package:parcel_sellerapp/models/addressmod.dart';
import 'package:parcel_sellerapp/models/address_changer.dart';
import 'package:parcel_sellerapp/models/address_design.dart';
import 'package:provider/provider.dart';

class CurrentAddress extends StatefulWidget {
  var userUID;

  @override
  _CurrentAddress createState() => _CurrentAddress();
}

class _CurrentAddress extends State<CurrentAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Route newRoute = MaterialPageRoute(builder: (_) => Cart());
            Navigator.pushReplacement(context, newRoute);
          },
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Rider'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Add New Address'),
        backgroundColor: Colors.cyan,
        icon: const Icon(
          Icons.add_location,
          color: Colors.white,
        ),
        onPressed: () {
          Route newRoute =
              MaterialPageRoute(builder: (_) => SaveAddressScreen());
          Navigator.pushReplacement(context, newRoute);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Select Address :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Consumer<AddressChanger>(builder: (context, address, c) {
            return Flexible(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("rider")
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : snapshot.data.docs.isEmpty
                            ? Container()
                            : ListView.builder(
                                itemCount: snapshot.data.docs.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return AddressDesign(
                                    currentIndex: address.count,
                                    value: index,
                                    addressID: snapshot.data.docs[index].id,
                                    userID: widget.userUID,
                                    model: Address.fromJson(
                                        snapshot.data.docs[index].data()
                                            as Map<String, dynamic>),
                                  );
                                },
                              );
                  }),
            );
          }),
        ],
      ),
    );
  }
}
