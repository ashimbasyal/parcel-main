import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parcel_sellerapp/address/text_field.dart';
import 'package:parcel_sellerapp/homepage/home.dart';
import 'package:parcel_sellerapp/models/addressmod.dart';

class SaveAddressScreen extends StatelessWidget {
  final _name = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _flatNumber = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _completeAddress = TextEditingController();
  final _locationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<Placemark> placemarks;
  Position position;
  User currentUser;

  getUserLocationAddress() async {
    Position newposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    position = newposition;
    placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark pMark = placemarks[0];

    String fulAddress =
        '${pMark.thoroughfare}${pMark.subLocality}${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';
    _locationController.text = fulAddress;

    _flatNumber.text =
        '${pMark.subThoroughfare}${pMark.thoroughfare}${pMark.subLocality}${pMark.locality}';
    _city.text =
        '${pMark.subAdministrativeArea},${pMark.administrativeArea},${pMark.postalCode}';
    _state.text = '${pMark.country}';
    _completeAddress.text = fulAddress;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.white),
          onPressed: () {
            Route newRoute =
                MaterialPageRoute(builder: (_) =>  HomePage());
            Navigator.pushReplacement(context, newRoute);
          },
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Rider'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Save Now'),
        icon: const Icon(Icons.save),
        onPressed: () {
          // Route newRoute =
          //     MaterialPageRoute(builder: (context) => PostAddress());
          // Navigator.pushReplacement(context, newRoute);
          //save address info

          if (formKey.currentState.validate()) {
            final model = Address(
              name: _name.text.trim(),
              state: _state.text.trim(),
              fullAddress: _completeAddress.text.trim(),
              phoneNumber: _phoneNumber.text.trim(),
              flatNumber: _flatNumber.text.trim(),
              city: _city.text.trim(),
              lat: position.latitude,
              lng: position.longitude,
            ).toJson();
            FirebaseFirestore.instance
                .collection("users")
                .doc(DateTime.now().microsecondsSinceEpoch.toString())
                .set(model)
                .then((value) {
              Fluttertoast.showToast(msg: "new address have been saved");
              formKey.currentState.reset();
              // Route newRoute =
              //     MaterialPageRoute(builder: (context) =>  PostAddress());
              // Navigator.pushReplacement(context, newRoute);
            });
          }
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Align(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Save Address:',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.person_pin_circle,
                color: Colors.black,
                size: 35,
              ),
              title: Container(
                width: 250,
                child: TextField(
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  controller: _locationController,
                  decoration: const InputDecoration(
                      hintText: "What's your address?",
                      hintStyle: TextStyle(color: Colors.black)),
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  //get current location
                  getUserLocationAddress();
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(color: Colors.cyan))),
                ),
                icon: const Icon(
                  Icons.location_on,
                  color: Colors.black,
                ),
                label: const Text(
                  "Get My Current Location",
                  style: TextStyle(color: Colors.white),
                )),
            const SizedBox(
              height: 6,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  MyTextField(
                    hint: "Name",
                    controller: _name,
                  ),
                  MyTextField(
                    hint: "phone number",
                    controller: _phoneNumber,
                  ),
                  MyTextField(
                    hint: "city",
                    controller: _city,
                  ),
                  MyTextField(
                    hint: "state/Country",
                    controller: _state,
                  ),
                  MyTextField(
                    hint: "FlatNumber",
                    controller: _flatNumber,
                  ),
                  MyTextField(
                    hint: "Complete address",
                    controller: _completeAddress,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
