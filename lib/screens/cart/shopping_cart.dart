import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/models/products_model.dart';
import 'package:frontend/screens/order/placeOrder.dart';
import 'package:frontend/styles/style_sheet.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  bool isLoading = true;
  final deals = <ProductsModel>[];
  String cart = '';
  bool isEmpty = false;

  getProducts() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      cart = documentSnapshot.get('cart');
    });

    await FirebaseFirestore.instance
        .collection('Products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        final s = ProductsModel(
            images: doc['images'],
            title: doc['title'],
            totalRating: double.parse(doc['total_rating'].toString()),
            oldPrice: doc['oldPrice'],
            productID: doc['product_id'],
            newPrice: doc['newPrice']);
        cart.split(',').forEach((element) {
          if (s.productID == element.split(':')[0]) {
            s.quantity = element.split(':')[1];
            deals.add(s);
          }
        });
      });
    });
    double price = 0.0;
    deals.forEach((element) {
      print(double.parse(element.newPrice));
      price += double.parse(element.newPrice) * double.parse(element.quantity);
    });
    subtotal = price.toString();
    setState(() {
      isLoading = false;
    });
  }

  updateQuantity() async {
    String updates = '';
    for (final deal in deals) {
      cart.split(',').forEach((element) {
        if (element.split(':')[0] == deal.productID) {
          if (updates != '') updates += ',';
          updates += deal.productID + ':' + deal.quantity;
        }
      });
    }
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({'cart': updates}).catchError((e) {
      print(e);
    });
  }

  String subtotal;

  changeSubtotal() {
    double price = 0.0;
    deals.forEach((element) {
      print(double.parse(element.newPrice));
      price += double.parse(element.newPrice) * double.parse(element.quantity);
    });
    setState(() {
      subtotal = price.toString();
    });
  }

  Future<String> getUserCart() async {
    String val;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      val = documentSnapshot.get('cart');
    }).catchError((e) {
      print(e);
      val = 'An error occured';
    });
    return val;
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> removeFromCart(String productID) async {
    showLoaderDialog(context);

    String val = '';

    String cart = await getUserCart();
    if (cart == 'An error occured') {
      val = 'An error occured';
    }

    if (val == '') {
      String newCart = '';
      cart.split(',').forEach((element) {
        if (element.split(':')[0] != productID) {
          if (newCart != '')
            newCart += ',$element';
          else
            newCart += element;
        }
      });
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({'cart': newCart})
          .then((value) => val = 'Removed from Cart')
          .catchError((e) {
            val = 'An error occured';
            print(e);
          });
    }

    final snackBar = SnackBar(content: Text(val));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Navigator.pop(context);
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        updateQuantity();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Shopping Cart',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : cart.length == 0 || isEmpty
                ? Center(
                    child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/empty_cart.png",
                              width: MediaQuery.of(context).size.width * 0.5,
                            ),
                            Text('Your cart is empty', style: TextStyle(fontSize: 23))
                          ]),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Items',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: ListView.builder(
                            itemCount: deals.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: UniqueKey(),
                                direction: DismissDirection.endToStart,
                                confirmDismiss:
                                    (DismissDirection direction) async {
                                  return await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Confirm"),
                                        content: const Text(
                                            "Are you sure you wish to delete this product from your cart?"),
                                        actions: <Widget>[
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              child: const Text("Cancel")),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            child: const Text("Delete"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                onDismissed: (_) async {
                                  await removeFromCart(deals[index].productID);
                                  setState(() {
                                    deals.removeAt(index);
                                    if (deals.length == 0) isEmpty = true;
                                  });
                                  changeSubtotal();
                                },
                                background: Container(
                                  color: Colors.red,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(
                                      CupertinoIcons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        offset: Offset(0.0, 1.0),
                                        blurRadius: 3.0,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.network(
                                            deals[index].images[0],
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                deals[index].title,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    '\$' +
                                                        (int.parse(deals[index]
                                                                    .oldPrice) *
                                                                int.parse(deals[
                                                                        index]
                                                                    .quantity))
                                                            .toString(),
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade400,
                                                        fontSize: 17,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    '\$' +
                                                        (int.parse(deals[index]
                                                                    .newPrice) *
                                                                int.parse(deals[
                                                                        index]
                                                                    .quantity))
                                                            .toString(),
                                                    style: TextStyle(
                                                      color:
                                                          MyColors.PrimaryColor,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              RatingBarIndicator(
                                                rating:
                                                    deals[index].totalRating,
                                                itemBuilder: (context, index) =>
                                                    Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemCount: 5,
                                                itemSize: 15.0,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                deals[index].quantity =
                                                    (int.parse(deals[index]
                                                                .quantity) +
                                                            1)
                                                        .toString();
                                              });
                                              changeSubtotal();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 1),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: MyColors.PrimaryColor),
                                              child: Text('+',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(deals[index].quantity,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600)),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (int.parse(
                                                      deals[index].quantity) >
                                                  1)
                                                setState(() {
                                                  deals[index].quantity =
                                                      (int.parse(deals[index]
                                                                  .quantity) -
                                                              1)
                                                          .toString();
                                                });
                                              changeSubtotal();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 1),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: MyColors.PrimaryColor),
                                              child: Text('−',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'SubTotal',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '\$$subtotal',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Shipping Charges',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '\$0',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    child: Divider(
                                  height: 1,
                                  color: Colors.grey,
                                )),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      '\$$subtotal',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SubmitButton(
                                  text: 'Checkout',
                                  onPress: () {
                                    String updates = '';
                                    for (final deal in deals) {
                                      cart.split(',').forEach((element) {
                                        if (element.split(':')[0] == deal.productID) {
                                          if (updates != '') updates += ',';
                                          updates += deal.productID + ':' + deal.quantity;
                                        }
                                      });
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PlaceOrder(
                                            products: updates,
                                            subtotal: subtotal,
                                          )));
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
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
