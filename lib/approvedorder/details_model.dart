import 'package:flutter/material.dart';
import 'package:parcel_sellerapp/models/addressmod.dart';

class DetailsDesign extends StatefulWidget {
  final Address model;
  final int currentIndex;
  final int value;
  final String phoneId;
  final String addressID;
  final String userID;

  DetailsDesign(
      {this.model,
      this.currentIndex,
      this.value,
      this.phoneId,
      this.addressID,
      this.userID});

  @override
  _AddressDesignState createState() => _AddressDesignState();
}

class _AddressDesignState extends State<DetailsDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //select this address
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              const Text(
                                "Name: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model.name.toString()),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text(
                                "Phone no: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(widget.model.phoneNumber.toString()),
                            ],
                          ),
                          TableRow(children: [
                            const Text(
                              "Full Address: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(widget.model.fullAddress.toString()),
                          ]),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
