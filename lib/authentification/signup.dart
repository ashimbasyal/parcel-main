import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parcel_sellerapp/global/global.dart';
import 'package:parcel_sellerapp/homepage/home.dart';
import 'package:parcel_sellerapp/widgets/custom.dart';
import 'package:parcel_sellerapp/widgets/dialog.dart';
import 'package:parcel_sellerapp/widgets/loading.dart';
import 'package:firebase_storage/firebase_storage.dart' as f_storage;
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController licenseController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  File imageFile;
  final picker = ImagePicker();

  chooseImage(ImageSource source) async {
    final PickedFile = await picker.getImage(source: source);
    setState(() {
      imageFile = File(PickedFile.path);
    });
  }

  XFile imageXFile;
  final ImagePicker _picker = ImagePicker();

  Position position;
  List<Placemark> placeMarks;
  String sellerImageUrl = "";
  String licenseImageUrl = "";
  String completeAddress = "";

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageXFile;
    });
  }

  getCurrentLocation() async {
    Position newPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    position = newPosition;
    placeMarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark pMark = placeMarks[0];

    completeAddress =
        '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality} ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';
    locationController.text = completeAddress;
  }

  Future<void> formValidation() async {
    if (imageXFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Please Select an image.",
            );
          });
    } else if (imageFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Please Select an image.",
            );
          });
    }

    {
      if (passwordController.text == confirmPasswordController.text) {
        if (confirmPasswordController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            nameController.text.isNotEmpty &&
            phoneController.text.isNotEmpty &&
            licenseController.text.isNotEmpty &&
            locationController.text.isNotEmpty) {
          //start uploading image
          showDialog(
              context: context,
              builder: (c) {
                return LoadingDialog(
                  message: "Registering Account",
                );
              });
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          f_storage.Reference reference = f_storage.FirebaseStorage.instance
              .ref()
              .child("rider")
              .child(fileName);
          f_storage.UploadTask uploadTask =
              reference.putFile(File(imageFile.path));

          f_storage.TaskSnapshot taskSnapshot =
              await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((url) {
            licenseImageUrl = url;

            // save info to firestorm db
            authenticateSellerAndSignUp();
          });
        } else {
          showDialog(
              context: context,
              builder: (c) {
                return ErrorDialog(
                  message: "Please fill all the information.",
                );
              });
        }
      } else {
        showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: "Password do not match.",
              );
            });
      }
    }
  }

  void authenticateSellerAndSignUp() async {
    User currentUser;

    await firebaseAuth
        .createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          });
    });

    if (currentUser != null) {
      saveDataToFirestore(currentUser).then((value) {
        Navigator.pop(context);
        //sends user to home page
        Route newRoute = MaterialPageRoute(builder: (c) => HomePage());
        Navigator.pushReplacement(context, newRoute);
      });
    }
  }

  Future saveDataToFirestore(User currentUser) async {
    FirebaseFirestore.instance.collection("rider").doc(currentUser.uid).set({
      "riderUID": currentUser.uid,
      "riderEmail": currentUser.email,
      "riderName": nameController.text.trim(),
      "licenseImageUrl": licenseImageUrl,
      "phone": phoneController.text.trim(),
      "license no": licenseController.text.trim(),
      "address": completeAddress,
      "status": "approved",
      "lat": position.latitude,
      "lng": position.longitude,
    });

    // save data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("uid", currentUser.uid);
    await sharedPreferences.setString("email", currentUser.email.toString());
    await sharedPreferences.setString("name", nameController.text.trim());
    await sharedPreferences.setString("photoURL", sellerImageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              _getImage();
            },
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.20,
              backgroundColor: Colors.white,
              backgroundImage:
                  imageXFile == null ? null : FileImage(File(imageXFile.path)),
              child: imageXFile == null
                  ? Icon(
                      Icons.add_photo_alternate,
                      size: MediaQuery.of(context).size.width * 0.20,
                      color: Colors.grey,
                    )
                  : null,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Form(
            key: _formkey,
            child: Column(
              children: [
                CustomTextfield(
                  data: Icons.person,
                  controller: nameController,
                  hintText: "Name",
                  isObsecre: false,
                ),
                CustomTextfield(
                  data: Icons.email,
                  controller: emailController,
                  hintText: "Email",
                  isObsecre: false,
                ),
                CustomTextfield(
                  data: Icons.lock,
                  controller: passwordController,
                  hintText: "Password",
                  isObsecre: true,
                ),
                CustomTextfield(
                  data: Icons.lock,
                  controller: confirmPasswordController,
                  hintText: "Conform Password",
                  isObsecre: true,
                ),
                CustomTextfield(
                  data: Icons.phone,
                  controller: phoneController,
                  hintText: "Phone",
                  isObsecre: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                          child: imageFile != null
                              ? Container(
                                  height: 300,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(imageFile))),
                                )
                              : Container(
                                  height: 300,
                                  width: 300,
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                )),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FlatButton(
                                  onPressed: () {
                                    chooseImage(ImageSource.camera);
                                  },
                                  color: Colors.red,
                                  child: const Text(
                                    'Camera',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FlatButton(
                                  onPressed: () {
                                    chooseImage(ImageSource.gallery);
                                  },
                                  color: Colors.red,
                                  child: const Text(
                                    'Gallery',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                CustomTextfield(
                  data: Icons.confirmation_number,
                  controller: licenseController,
                  hintText: " Licence No",
                  isObsecre: false,
                ),
                CustomTextfield(
                  data: Icons.my_location,
                  controller: locationController,
                  hintText: "Current Location",
                  isObsecre: false,
                  enabled: false,
                ),
                Container(
                  width: 400,
                  height: 40,
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    label: const Text(
                      "Get my Location",
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      getCurrentLocation();
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: const Text(
              "Sign up",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            onPressed: () {
              formValidation();
            },
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
