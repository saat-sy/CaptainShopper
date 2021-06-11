import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/models/myOrders_model.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final orders = <MyOrdersModel>[];
  bool isLoading = true;

  Future<String> getProductImages(String productID) async {
    String image;
    await FirebaseFirestore.instance
        .collection('Products')
        .where('product_id', isEqualTo: productID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        image = doc['images'][0].toString();
      });
    });
    return image;
  }

  getOrders() async {
    String userOrders = '';
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      userOrders = documentSnapshot.get('orders');
    }).catchError((e) {
      print(e);
      userOrders = 'An error occured';
    });

    for (final element in userOrders.split(',')) {
      await FirebaseFirestore.instance
          .collection('Orders')
          .where('order_id', isEqualTo: int.parse(element))
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) {
          final m = MyOrdersModel(
            orderID: element['order_id'].toString(),
            reviewed: element['reviewed'],
            delivered: element['delivered'],
            productID: element['products'].split(':')[0],);
          orders.add(m);
        });
      });
    }
    for (final element in orders) {
      await getProductImages(element.productID)
          .then((value) => element.images = value);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 15),
                    child: Text(
                      'My Orders',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8)),
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Order#: " + orders[index].orderID,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17,
                                            )),
                                        SizedBox(height: 3),
                                        Text('05-May-2021, 3:00PM',
                                            style: TextStyle(
                                              color: Colors.grey.shade500,
                                            )),
                                      ],
                                    ),
                                    Image.network(orders[index].images,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2)
                                  ]),
                              SizedBox(height: 20),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      orders[index].delivered
                                          ? "Delivered"
                                          : "Not Delivered",
                                      style: TextStyle(
                                          color: orders[index].delivered
                                              ? Colors.redAccent.shade400
                                              : Colors.green),
                                    ),
                                    Row(children: [
                                      Text(orders[index].reviewed
                                          ? "You Rated"
                                          : "Not Rated"),
                                    ])
                                  ])
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
