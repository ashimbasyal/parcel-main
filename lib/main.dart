import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parcel_sellerapp/splashscreen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'models/address_changer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "parcel-rider-app-clone",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:  (c)=> AddressChanger())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home:  MySplashScreen()),
    );
  }
}
