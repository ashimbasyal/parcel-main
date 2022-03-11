import 'package:flutter/material.dart';
import 'package:parcel_sellerapp/authentification/auth_screen.dart';
import 'package:parcel_sellerapp/cart/cart.dart';
import 'package:parcel_sellerapp/orders/order.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Card makeDashboardItem(String title, IconData iconData, int index) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: index == 0 || index == 3 || index == 4
            ? const BoxDecoration(color: Colors.cyan)
            : const BoxDecoration(
                color: Colors.red,
              ),
        child: InkWell(
          onTap: () {
            if (index == 0) {
              //job list ma janxa rider
              Route newRoute = MaterialPageRoute(builder: (_) => Cart());
              Navigator.pushReplacement(context, newRoute);
            }
            if (index == 1) {
              //parcel in progess
              Route newRoute = MaterialPageRoute(builder: (_) => OrdersCart());
              Navigator.pushReplacement(context, newRoute);
            }
            if (index == 2) {
              //Not yet deliver

              // Route newRoute =
              //     MaterialPageRoute(builder: (_) =>  ApprovedOrder());
              // Navigator.pushReplacement(context, newRoute);
            }

            if (index == 3) {
              //logout
              Route newRoute = MaterialPageRoute(builder: (_) => AuthScreen());
              Navigator.pushReplacement(context, newRoute);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Icon(
                  iconData,
                  size: 40,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rider'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 1),
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(2),
          children: [
            makeDashboardItem("Take New Delivery", Icons.assessment, 0),
            makeDashboardItem("Pending", Icons.airport_shuttle, 1),
            makeDashboardItem("Approved", Icons.location_history, 2),
            makeDashboardItem("Logout", Icons.logout, 3),
          ],
        ),
      ),
    );
  }
}
