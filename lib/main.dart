import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parcel_sellerapp/controller/controller.dart';
import 'package:parcel_sellerapp/global/global.dart';
import 'package:parcel_sellerapp/splashscreen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=>ParcelNotifier()),],
        child: const MyApp()
    ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Users App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MySplashScreen(),
    );
  }
}

