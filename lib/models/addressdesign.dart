import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parcel_sellerapp/approvedorder/details.dart';
import 'package:parcel_sellerapp/maps/maps.dart';
import 'package:parcel_sellerapp/models/addressmod.dart';
import 'package:parcel_sellerapp/models/address_changer.dart';
import 'package:provider/provider.dart';

class AddressDesign extends StatefulWidget {
  final Address model;
  final int currentIndex;
  final int value;
  final String addressID;
  final String userID;

  AddressDesign(
      {this.model, this.currentIndex, this.value, this.addressID, this.userID});

  @override
  _AddressDesignState createState() => _AddressDesignState();
}

class _AddressDesignState extends State<AddressDesign> {
  @override
  Widget build(BuildContext context) {
    print(widget.addressID);
    return InkWell(
      onTap: () {
        //select this address

        Provider.of<AddressChanger>(context, listen: false)
            .displayResult(widget.value);
      },
      child: Card(
        color: Colors.white.withOpacity(0.4),
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                  value: widget.value,
                  groupValue: widget.currentIndex,
                  activeColor: Colors.green,
                  onChanged: (val) {
                    //provider
                    Provider.of<AddressChanger>(context, listen: false)
                        .displayResult(val);

                    print(val);
                  },
                ),
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
                          TableRow(children: [
                            const Text(
                              "Flat Number: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(widget.model.flatNumber.toString()),
                          ]),
                          TableRow(children: [
                            const Text(
                              "City: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(widget.model.city.toString()),
                          ]),
                          TableRow(children: [
                            const Text(
                              "State: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(widget.model.state.toString()),
                          ]),
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
            ElevatedButton(
              child: const Text(
                "Check on Maps",
              ),
              style: ElevatedButton.styleFrom(primary: Colors.black54),
              onPressed: () {
                MapsUtils.openMapWithAddress(widget.model.fullAddress);
              },
            ),

            //button
            widget.value == Provider.of<AddressChanger>(context).count
                ? ElevatedButton(
                    child: const Text('proceed'),
                    onLongPress: showMessage,
                    onPressed: () {
                      Route newRoute = MaterialPageRoute(
                          builder: (context) => Details(
                                documentId: widget.addressID,
                              ));
                      Navigator.pushReplacement(context, newRoute);
                    },
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

void showMessage() =>
    Fluttertoast.showToast(msg: "your new destination has been saved");
