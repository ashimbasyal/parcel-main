import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class PickupLocation extends StatefulWidget {
  @override
  State<PickupLocation> createState() => _PickupLocationState();
}

class _PickupLocationState extends State<PickupLocation> {
  double userLat, userLng;

  getUserData() async {
    FirebaseFirestore.instance
        .collection("user")
        .doc()
        .get()
        .then((DocumentSnapshot) {
      DocumentSnapshot.data()['lat'];
      DocumentSnapshot.data()['lng'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            "https://www.nicepng.com/png/detail/197-1976322_become-a-rider-delivery-bike-rider.png",
            width: 370,
          ),
          const SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              // MApUtils.launchMapFromSourceToDestination(
              //     27.5966807, 85.1563199, 'New', 'Baneshwor');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHIfkh4tkfRYoVsPgLv4KknRh_RdbiSR4wKES4YBu51GjjsxdCMcJrsIcr6gRuXn0meps&usqp=CAU",
                  width: 30,
                ),
                const SizedBox(
                  width: 7,
                ),
                Column(
                  children: const [
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "View Pickup Location",
                      style: TextStyle(letterSpacing: 2, fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: InkWell(
                onTap: () {
                  // Route newRoute =
                  //     MaterialPageRoute(builder: (context) => DropLocation());
                  // Navigator.pushReplacement(context, newRoute);
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.green),
                  width: MediaQuery.of(context).size.width - 90,
                  height: 50,
                  child: const Center(
                    child: Text(
                      "Confirm order has been picked",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
