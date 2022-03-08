import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:parcel_sellerapp/address/address.dart';
import 'package:parcel_sellerapp/approvedorder/details.dart';
import 'package:parcel_sellerapp/cart/cart_model.dart';
import 'package:parcel_sellerapp/homepage/home.dart';
import 'package:parcel_sellerapp/models/addressmod.dart';

class OrdersCart extends StatefulWidget {
  var userUID;
  var id;
  final Address model;
  final int currentIndex;
  final int value;
  final String addressID;
  final String userID;
  OrdersCart(
      {this.model, this.currentIndex, this.value, this.addressID, this.userID});
  @override
  _OrdersCartState createState() => _OrdersCartState();
}

class _OrdersCartState extends State<OrdersCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Route newRoute = MaterialPageRoute(builder: (_) => HomePage());
            Navigator.pushReplacement(context, newRoute);
          },
        ),
        centerTitle: true,
        title: const Text('Take orders'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: JobList.listitm.length,
              itemBuilder: (BuildContext context, int index) {
                return CartPage(jobList: JobList.listitm[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final JobList jobList;
  const CartPage({
    Key key,
    this.jobList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var products = Product.products.where(logic)

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Id: ' "${jobList.id}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat('dd-MM-yy').format(jobList.createdAt),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.network(
                              'https://parceljs.org/assets/og.png',
                              fit: BoxFit.cover),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Parcel Id:' "${jobList.parcelId}",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              width: 275,
                              child: Text(
                                'Deliver this parcel near your area',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Delivery charge',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${jobList.deliveryCharge}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${jobList.total}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Route newRoute = MaterialPageRoute(
                            builder: (context) => Details(
                                // documentId: widget.addressID,
                                ));
                        Navigator.pushReplacement(context, newRoute);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          minimumSize: const Size(
                            150,
                            40,
                          )),
                      child: const Text('Accept')),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          minimumSize: const Size(
                            150,
                            40,
                          )),
                      child: const Text('Cancel'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
