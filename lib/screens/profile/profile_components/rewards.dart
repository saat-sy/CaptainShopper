import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/styles/style_sheet.dart';

class Rewards extends StatefulWidget {
  @override
  _RewardsState createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  int currentPoints, lifetimePoints;
  String couponHistory, pointsHistory, coupons;
  String rewardPoints;

  bool isLoading = true;

  final availableRedeem = <String>[];
  final availableRedeemPoints = <String>[];
  final couponHistoryList = <String>[];
  final pointsHistoryList = <String>[];

  getData() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      currentPoints = documentSnapshot.get('currentPoints');
      lifetimePoints = documentSnapshot.get('lifetimePoints');
      pointsHistory = documentSnapshot.get('points_history');
      couponHistory = documentSnapshot.get('coupon_history');
      coupons = documentSnapshot.get('coupons');
    });

    await FirebaseFirestore.instance.collection("Rewards").get().then((value) {
      value.docs.forEach((element) {
        rewardPoints = element['fields'];
      });
    });

    rewardPoints.split(',').forEach((element) {
      if (currentPoints >= int.parse(element.split(':')[0])) {
        availableRedeem.add(element.split(':')[1]);
        availableRedeemPoints.add(element.split(':')[0]);
      }
    });

    if (couponHistory != '')
      couponHistory.split(',').forEach((element) {
        couponHistoryList.add(element);
      });

    if (pointsHistory != '')
      pointsHistory.split(',').forEach((element) {
        pointsHistoryList.add(element.split(':')[1]);
      });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  String info1 =
      'Earn points each time you complete various activities through the app \n\nRedeem your points for for coupons and get discounts on your next purchase.';

  String info2 = 'How do I earn points?';

  String info3 = 'How do I use my points?';
  String info4 =
      'Redeem your points for coupons and get extra discounts. Tap on the \'Redeem\' tab to get started.';

  String info5 = 'How do I use my coupons?';
  String info6 =
      'Redeem your points for coupons and get extra discounts. Tap on the \'Redeem\' tab to get started.';

  String info7 = 'Do my points expire?';
  String info8 = 'No, points are always available for you to redeem.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Rewards'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: Center(
                        child: TabBar(
                          isScrollable: true,
                          labelColor: Colors.black,
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                          unselectedLabelStyle: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15),
                          indicatorSize: TabBarIndicatorSize.tab,
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Container(
                              height: 35.0,
                              child: Tab(
                                child: Text('Dashboard'),
                              ),
                            ),
                            Container(
                              height: 35.0,
                              child: Tab(
                                child: Text('Redeem'),
                              ),
                            ),
                            Container(
                              height: 35.0,
                              child: Tab(
                                child: Text('Information'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: TabBarView(children: <Widget>[
                          Container(
                            child: Column(
                              children: [
                                Container(
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
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: MyColors.PrimaryColor),
                                            child: Text(
                                                currentPoints.toString(),
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
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: MyColors.PrimaryColor
                                                    .withOpacity(0.15)),
                                            child: Text(
                                                'Lifetime Score: ${lifetimePoints.toString()}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                    color:
                                                        MyColors.PrimaryColor)))
                                      ],
                                    )),
                                Expanded(
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: DefaultTabController(
                                        length: 3,
                                        initialIndex: 0,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: <Widget>[
                                              Container(
                                                child: Center(
                                                  child: TabBar(
                                                    isScrollable: true,
                                                    labelColor: Colors.black,
                                                    labelStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                    unselectedLabelStyle:
                                                        TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 15),
                                                    indicatorSize:
                                                        TabBarIndicatorSize.tab,
                                                    unselectedLabelColor:
                                                        Colors.grey,
                                                    tabs: [
                                                      Container(
                                                        height: 35.0,
                                                        width: 80.0,
                                                        child: Tab(
                                                          child:
                                                              Text('Available'),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 35.0,
                                                        width: 80.0,
                                                        child: Tab(
                                                          child: Text('Used'),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 35.0,
                                                        width: 80.0,
                                                        child: Tab(
                                                          child:
                                                              Text('History'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                    color: Colors.grey.shade200,
                                                    child: TabBarView(
                                                        children: <Widget>[
                                                          Available(
                                                              availableRedeem),
                                                          Used(
                                                              couponHistoryList),
                                                          PointsHistory(
                                                              pointsHistoryList)
                                                        ])),
                                              )
                                            ])),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.grey.shade200,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Text('Use your points!',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      'Use your points to redeem coupons and use them with your next purchase (Maximum discount of \$10)',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey)),
                                  SizedBox(height: 20),
                                  Expanded(
                                      child: Redeem(
                                    availableRedeem,
                                    availableRedeemPoints,
                                    coupons,
                                    currentPoints,
                                    couponsHistory: couponHistory,
                                  ))
                                ]),
                          ),
                          Container(
                            padding: EdgeInsets.all(15),
                            child: ListView(
                              children: [
                                Text(info1, style: TextStyle(fontSize: 17)),
                                SizedBox(height: 20),
                                Text(info2,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 3),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      border: Border(
                                        top: BorderSide(color: Colors.grey),
                                        bottom: BorderSide(color: Colors.grey),
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('POINTS',
                                                style: TextStyle(fontSize: 17)),
                                            SizedBox(height: 7),
                                            Text('100',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(height: 3),
                                            Text('15',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(height: 3),
                                            Text('10',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                        SizedBox(width: 25),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('ACTION',
                                                style: TextStyle(fontSize: 17)),
                                            SizedBox(height: 7),
                                            Text('Make a purchase',
                                                style: TextStyle(fontSize: 17)),
                                            SizedBox(height: 3),
                                            Text('Review a purchase',
                                                style: TextStyle(fontSize: 17)),
                                            SizedBox(height: 3),
                                            Text(
                                                'Upload a photo with your review',
                                                style: TextStyle(fontSize: 17)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(info3,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 3),
                                Text(info4, style: TextStyle(fontSize: 17)),
                                SizedBox(height: 10),
                                Text(info5,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 3),
                                Text(info6, style: TextStyle(fontSize: 17)),
                                SizedBox(height: 10),
                                Text(info7,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 3),
                                Text(info8, style: TextStyle(fontSize: 17))
                              ],
                            ),
                          ),
                        ]))
                  ])),
    );
  }
}

class Available extends StatelessWidget {
  List<String> available;
  Available(this.available);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: available.length == 0
          ? Center(
              child: Text('You have no Coupons',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
            )
          : Container(
              child: ListView.builder(
                itemCount: available.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1.0),
                      ),
                      child: Row(children: [
                        Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    color: Colors.grey.shade300, width: 1.0),
                              ),
                            ),
                            child: Text('${available[index]}%',
                                style: TextStyle(
                                    color: MyColors.PrimaryColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold))),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('OFF',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 3),
                              Text(
                                'Entire Purchase',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        )
                      ]));
                },
              ),
            ),
    );
  }
}

class Used extends StatelessWidget {
  List<String> used;
  Used(this.used);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: used.length == 0
          ? Center(
              child: Text('You have not used any Coupons',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
            )
          : Container(
              child: ListView.builder(
                itemCount: used.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1.0),
                      ),
                      child: Row(children: [
                        Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    color: Colors.grey.shade300, width: 1.0),
                              ),
                            ),
                            child: Text('${used[index]}%',
                                style: TextStyle(
                                    color: MyColors.PrimaryColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold))),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('OFF',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 3),
                              Text(
                                'Entire Purchase',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        )
                      ]));
                },
              ),
            ),
    );
  }
}

class PointsHistory extends StatelessWidget {
  List<String> points;
  PointsHistory(this.points);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: points.length == 0
          ? Center(
              child: Text('No history',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
            )
          : Container(
              child: ListView.builder(
                itemCount: points.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1.0),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: MyColors.PrimaryColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(CupertinoIcons.pencil,
                                    color: MyColors.PrimaryColor, size: 20),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Review Bonus',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600)),
                                    Text(points[index],
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                        )),
                                  ]),
                            ]),
                            Text('+10',
                                style: TextStyle(
                                    color: MyColors.PrimaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ]));
                },
              ),
            ),
    );
  }
}

class Redeem extends StatefulWidget {
  List<String> redeem;
  List<String> redeemPoints;
  String coupons;
  int currentPoints;
  String couponsHistory;
  Redeem(this.redeem, this.redeemPoints, this.coupons, this.currentPoints,
      {this.couponsHistory});

  @override
  _RedeemState createState() => _RedeemState();
}

class _RedeemState extends State<Redeem> {
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

  addCoupon(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Redeem coupon"),
            content: Text(
                "${widget.redeemPoints[index]} points will be deducted from your points"),
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Cancel")),
              TextButton(
                onPressed: () async {
                  showLoaderDialog(context);
                  String val;

                  String coupon = widget.coupons;
                  if (coupon.isNotEmpty) coupon += ',';

                  String couponHis = widget.couponsHistory;
                  if (couponHis.isNotEmpty) couponHis += ',';

                  await FirebaseFirestore.instance
                      .collection('Users')
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .update({
                        'coupons': coupon + widget.redeem[index],
                        'couponsHistory': couponHis + widget.redeem[index],
                        'currentPoints': widget.currentPoints -
                            int.parse(widget.redeemPoints[index]),
                      })
                      .then((value) => val = 'Removed from Cart')
                      .catchError((e) {
                        val = 'An error occured';
                        print(e);
                      });

                  final snackBar = SnackBar(content: Text('Succesfully Redeemed!'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);    

                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("Continue"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.redeem.length == 0
          ? Center(
              child: Text('You have no Coupons to Redeem',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
            )
          : Container(
              child: ListView.builder(
                itemCount: widget.redeem.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      addCoupon(index);
                    },
                    child: Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1.0),
                        ),
                        child: Row(children: [
                          Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                      color: Colors.grey.shade300, width: 1.0),
                                ),
                              ),
                              child: Text('${widget.redeem[index]}%',
                                  style: TextStyle(
                                      color: MyColors.PrimaryColor,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold))),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('OFF',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 3),
                                Text(
                                  'Entire Purchase',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          )
                        ])),
                  );
                },
              ),
            ),
    );
  }
}
