import 'package:flutter/material.dart';
import 'package:parcel_sellerapp/authentification/login.dart';
import 'package:parcel_sellerapp/authentification/signup.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState(); 
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Colors.black),
          ),
          automaticallyImplyLeading: false,
          title: const Text(
            "Parcel",
            style: TextStyle(fontSize: 60.0, color: Colors.white),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                text: 'Login',
              ),
              Tab(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                text: 'SignUp',
              ),
            ],
            indicatorColor: Colors.white,
            indicatorWeight: 6,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(color: Colors.black87),
          child: const TabBarView(
            children: [
              LoginScreen(),
              SignupScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
