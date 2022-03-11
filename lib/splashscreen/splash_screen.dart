import 'dart:async';

import 'package:flutter/material.dart';
import 'package:parcel_sellerapp/authentification/auth_screen.dart';
import 'package:parcel_sellerapp/global/global.dart';
import 'package:parcel_sellerapp/homepage/home.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 2), () async {
      if (firebaseAuth.currentUser != null) {
        Navigator.push(context, MaterialPageRoute(builder: (c) => HomePage()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => AuthScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(70.0),
                child: Image.asset("assets/images/splash.jpg"),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  "Post Job requests",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 40,
                    fontFamily: "Signatra",
                    letterSpacing: 3,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
