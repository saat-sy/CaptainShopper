import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/styles/style_sheet.dart';

class Rewards extends StatefulWidget {
  @override
  _RewardsState createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {

  String info1 = 'Earn points each time you complete various activities through the app \n\nRedeem your points for for coupons and get discounts on your next purchase.';

  String info2 = 'How do I earn points?';

  String info3 = 'How do I use my points?';
  String info4 = 'Redeem your points for coupons and get extra discounts. Tap on the \'Redeem\' tab to get started.';

  String info5 = 'How do I use my coupons?';
  String info6 = 'Redeem your points for coupons and get extra discounts. Tap on the \'Redeem\' tab to get started.' ;

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
      body: Stack(
        children: [
          DefaultTabController(
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
                                            child: Text('3,110',
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
                                                'Lifetime Score: 22,100',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                    color:
                                                        MyColors.PrimaryColor)))
                                      ],
                                    )),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 15),
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
                                                    labelColor:
                                                        Colors.black,
                                                    labelStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                    unselectedLabelStyle:
                                                        TextStyle(
                                                            fontWeight:
                                                                FontWeight.normal,
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
                                                          child: Text('History'),
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
                                                          Container(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                    'You have no Coupons',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .grey)),
                                                                SizedBox(
                                                                    height: 10),
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.6,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(5),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                                  5),
                                                                      color: MyColors
                                                                          .PrimaryColor),
                                                                  child: Center(
                                                                      child: Text(
                                                                          'How do I earn points?',
                                                                          textAlign: TextAlign.center,
                                                                          style:
                                                                              TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                MediaQuery.of(context).size.width * 0.05,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ))),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                            child: ListView.builder(
                                                              itemCount: 4,
                                                              itemBuilder:
                                                                  (context, index) {
                                                                return Container(
                                                                    margin:
                                                                        EdgeInsets
                                                                            .all(5),
                                                                    padding: EdgeInsets
                                                                        .symmetric(
                                                                            vertical:
                                                                                10),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                                  8),
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade300,
                                                                          width:
                                                                              1.0),
                                                                    ),
                                                                    child: Row(
                                                                        children: [
                                                                          Container(
                                                                              padding: EdgeInsets.all(
                                                                                  20),
                                                                              decoration:
                                                                                  BoxDecoration(
                                                                                border:
                                                                                    Border(
                                                                                  right: BorderSide(color: Colors.grey.shade300, width: 1.0),
                                                                                ),
                                                                              ),
                                                                              child: Text(
                                                                                  '\$10',
                                                                                  style: TextStyle(color: MyColors.PrimaryColor, fontSize: 25, fontWeight: FontWeight.bold))),
                                                                          Container(
                                                                            padding: EdgeInsets.symmetric(
                                                                                vertical:
                                                                                    10,
                                                                                horizontal:
                                                                                    20),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment:
                                                                                  CrossAxisAlignment.start,
                                                                              children: [
                                                                                Text('Off your next order',
                                                                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                                                                SizedBox(height: 3),
                                                                                Text(
                                                                                  'Daily Login Bonus-\$50 max',
                                                                                  style: TextStyle(color: Colors.grey),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          )
                                                                        ]));
                                                              },
                                                            ),
                                                          ),
                                                          Container(
                                                            child: ListView.builder(
                                                              itemCount: 7,
                                                              itemBuilder:
                                                                  (context, index) {
                                                                return Container(
                                                                    margin: EdgeInsets
                                                                        .symmetric(
                                                                            horizontal:
                                                                                5,
                                                                            vertical:
                                                                                2.5),
                                                                    padding: EdgeInsets
                                                                        .symmetric(
                                                                            vertical:
                                                                                10,
                                                                            horizontal:
                                                                                10),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                                  8),
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade300,
                                                                          width:
                                                                              1.0),
                                                                    ),
                                                                    child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .spaceBetween,
                                                                        children: [
                                                                          Row(
                                                                              children: [
                                                                                Container(
                                                                                  padding: EdgeInsets.all(5),
                                                                                  decoration: BoxDecoration(
                                                                                    color: MyColors.PrimaryColor.withOpacity(0.2),
                                                                                    borderRadius: BorderRadius.circular(50),
                                                                                  ),
                                                                                  child: Icon(CupertinoIcons.person_fill, color: MyColors.PrimaryColor, size: 20),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 7,
                                                                                ),
                                                                                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                                                                  Text('New User Bonus', style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600)),
                                                                                  Text('August 13, 2020',
                                                                                      style: TextStyle(
                                                                                        color: Colors.grey,
                                                                                        fontSize: 13,
                                                                                      )),
                                                                                ]),
                                                                              ]),
                                                                          Text(
                                                                              '+100',
                                                                              style: TextStyle(
                                                                                  color: MyColors.PrimaryColor,
                                                                                  fontSize: 18,
                                                                                  fontWeight: FontWeight.bold)),
                                                                        ]));
                                                              },
                                                            ),
                                                          ),
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
                                          fontSize: 16,
                                          color: Colors.grey)),
                                  SizedBox(height: 20),
                                  Container(
                                    height:MediaQuery.of(context).size.height * 0.55,
                                    child: ListView.builder(
                                      itemCount: 3,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.all(5),
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: Colors.grey.shade300, width: 1.0),
                                          ),
                                          child: Stack(
                                            children: [
                                              Row(
                                                children: [

                                                  Container(
                                                    padding: EdgeInsets.all(20),
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        right: BorderSide(color: Colors.grey.shade300, width: 1.0),
                                                      ),
                                                    ),
                                                    child: Text('5%',
                                                      style: TextStyle(
                                                        color: MyColors.PrimaryColor,
                                                        fontSize: 28,
                                                        fontWeight: FontWeight.bold
                                                      )
                                                    )
                                                  ),

                                                  Container(
                                                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text('OFF',
                                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                                        SizedBox(height: 3),
                                                        Text(
                                                          'Entire Purchase',
                                                          style: TextStyle(color: Colors.grey),
                                                        )
                                                      ],
                                                    ),
                                                  )

                                                ]
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      color: MyColors.PrimaryColor
                                                    ),
                                                    child: Center(
                                                      child: Text('200 pts', style: TextStyle(color: Colors.white))
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        );
                                      },
                                    ),
                                  )
                                ]),
                          ),
                          Container(
                            padding: EdgeInsets.all(15),
                            child: ListView(
                              
                              children: [

                                Text(info1, style: TextStyle(fontSize: 17)),

                                SizedBox(height: 20),

                                Text(info2, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),

                                SizedBox(height: 3),
                                
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    border: Border(
                                      top: BorderSide(color: Colors.grey),
                                      bottom: BorderSide(color: Colors.grey),
                                    )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('POINTS', style: TextStyle(fontSize: 17)),
                                            SizedBox(height: 7),
                                            Text('100', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                                            SizedBox(height: 3),
                                            Text('15', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                                            SizedBox(height: 3),
                                            Text('10', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                                          ],
                                        ),

                                        SizedBox(width: 25),

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('ACTION', style: TextStyle(fontSize: 17)),
                                            SizedBox(height: 7),
                                            Text('Make a purchase', style: TextStyle(fontSize: 17)),
                                            SizedBox(height: 3),
                                            Text('Review a purchase', style: TextStyle(fontSize: 17)),
                                            SizedBox(height: 3),
                                            Text('Upload a photo with your review', style: TextStyle(fontSize: 17)),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(height: 20),
                                
                                Text(info3, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),

                                SizedBox(height: 3),
                                
                                Text(info4, style: TextStyle(fontSize: 17)),

                                SizedBox(height: 10),

                                Text(info5, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),

                                SizedBox(height: 3),
                                
                                Text(info6, style: TextStyle(fontSize: 17)),

                                SizedBox(height: 10),

                                Text(info7, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),

                                SizedBox(height: 3),
                                
                                Text(info8, style: TextStyle(fontSize: 17))

                              ],
                            ),
                          ),
                        ]))
                  ])),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SubmitButton(
                  width: MediaQuery.of(context).size.width * 0.85,
                  text: 'Save Changes'),
            ),
          )
        ],
      ),
    );
  }
}
