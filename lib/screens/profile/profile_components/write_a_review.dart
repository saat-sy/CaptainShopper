import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/models/myOrders_model.dart';
import 'package:frontend/styles/style_sheet.dart';
import 'package:intl/intl.dart';

class WriteAReview extends StatefulWidget {
  @override
  _WriteAReviewState createState() => _WriteAReviewState();
}

class _WriteAReviewState extends State<WriteAReview> {
  final orders = <MyOrdersModel>[];
  bool isLoading = true;
  bool isPointsLoading = true;

  int currentPoints, lifetimePoints;

  double totalRating;

  String review, rating;

  var usernames = [], ratings = [], reviews = [];

  addReview(String productID, int orderID) async {
    showLoaderDialog(context);

    String docID;

    await FirebaseFirestore.instance
        .collection('Products')
        .where('product_id', isEqualTo: productID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        usernames = element['usernames'];
        ratings = element['ratings'];
        reviews = element['reviews'];
        totalRating = double.parse(element['total_rating'].toString());
        docID = element.id;
      });
    });

    usernames.add(FirebaseAuth.instance.currentUser.displayName);
    ratings.add(double.parse(rating.toString()));
    reviews.add(review);
    totalRating =
        (totalRating + double.parse(rating.toString())) / ratings.length;

    await FirebaseFirestore.instance.collection('Products').doc(docID).update({
      'usernames': usernames,
      'ratings': ratings,
      'reviews': reviews,
      'total_rating': totalRating
    }).catchError((e) {
      print(e);
    });

    int currentPoints;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      currentPoints = documentSnapshot.get('currentPoints');
    });

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({'currentPoints': currentPoints + 10}).catchError((e) {
      print(e);
    });

    int lifetimePoints;
    String points_history;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      lifetimePoints = documentSnapshot.get('lifetimePoints');
      points_history = documentSnapshot.get('points_history');
    });

    if(points_history != '') points_history += ',';

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({
          'lifetimePoints': lifetimePoints + 10,
          'points_history': points_history + '10:' + DateFormat("dd-MM-yyyy").format(DateTime.now())
        }).catchError((e) {
      print(e);
    });

    String orderDocID;
    await FirebaseFirestore.instance
        .collection('Orders')
        .where('order_id', isEqualTo: orderID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        orderDocID = element.id;
      });
    });

    await FirebaseFirestore.instance
        .collection('Orders')
        .doc(orderDocID)
        .update({'reviewed': true}).catchError((e) {
      print(e);
    });

    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
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

  showReviewDialog(BuildContext context, String productID, int orderID) {
    AlertDialog alert = AlertDialog(
        backgroundColor: Colors.white,
        content: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Please give your rating by clicking on the stars below.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 30,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  this.rating = rating.toString();
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                onChanged: (val) {
                  review = val;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                cursorColor: MyColors.PrimaryColor,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                    hintText: 'Tell us about your experience',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Colors.grey, width: 1.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide:
                            BorderSide(color: Colors.grey, width: 1.0))),
              ),
              SizedBox(
                height: 30,
              ),
              SubmitButton(
                text: 'Submit',
                onPress: () {
                  addReview(productID, orderID);
                },
              ),
            ],
          ),
        ));

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getPoints() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      currentPoints = documentSnapshot.get('currentPoints');
    });

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      lifetimePoints = documentSnapshot.get('lifetimePoints');
    });

    setState(() {
      isPointsLoading = false;
    });
  }

  Future<String> getProductTitle(String productID) async {
    String title;
    await FirebaseFirestore.instance
        .collection('Products')
        .where('product_id', isEqualTo: productID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        title = doc['title'].toString();
      });
    });
    return title;
  }

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
              orderID: element['order_id'].toString().padLeft(5, '0'),
              productID: element['products'].split(':')[0],
              reviewed: element['reviewed'],
              delivered: element['delivered']);
          if (!element['reviewed']) orders.add(m);
        });
      });
    }
    for (final element in orders) {
      await getProductImages(element.productID)
          .then((value) => element.images = value);

      await getProductTitle(element.productID)
          .then((value) => element.title = value);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getOrders();
    getPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Earn Points'),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(5),
                  color: MyColors.PrimaryColor.withOpacity(0.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline,
                          color: MyColors.PrimaryColor, size: 20),
                      SizedBox(width: 5),
                      Text('Write a review to earn points!',
                          style: TextStyle(
                              color: MyColors.PrimaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 15))
                    ],
                  )),
              isPointsLoading
                  ? Container(
                      height: 50,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : Container(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: [
                          Text('CURRENT POINTS'),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 30),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: MyColors.PrimaryColor),
                              child: Text(currentPoints.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                      color: Colors.white))),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color:
                                      MyColors.PrimaryColor.withOpacity(0.15)),
                              child: Text(
                                  'Lifetime Score: ${lifetimePoints.toString()}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: MyColors.PrimaryColor)))
                        ],
                      )),
              Container(
                height: MediaQuery.of(context).size.height * 0.55,
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 1.0),
                              ),
                              child: Stack(
                                children: [
                                  Row(children: [
                                    Container(
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right: BorderSide(
                                                color: Colors.grey.shade300,
                                                width: 1.0),
                                          ),
                                        ),
                                        child: Image.network(
                                            orders[index].images,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2)),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(orders[index].title,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(height: 3),
                                          InkWell(
                                            onTap: () {
                                              showReviewDialog(
                                                  context,
                                                  orders[index].productID,
                                                  int.parse(
                                                      orders[index].orderID));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: MyColors.PrimaryColor),
                                              child: Center(
                                                  child: Text('Write a Review',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ]),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: MyColors.PrimaryColor),
                                        child: Center(
                                            child: Text('10 pts',
                                                style: TextStyle(
                                                    color: Colors.white))),
                                      ),
                                    ],
                                  )
                                ],
                              ));
                        },
                      ),
              )
            ],
          ),
        ));
  }
}
