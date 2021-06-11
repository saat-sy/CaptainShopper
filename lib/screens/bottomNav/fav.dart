import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/models/coupon_model.dart';
import 'package:frontend/models/products_model.dart';
import 'package:frontend/models/giveaway_model.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  bool isLoadingGiveaway = true;
  bool isLoadingProducts = true;
  bool isLoadingCoupon = true;

  final giveaway = <GiveawayModel>[];
  final deals = <ProductsModel>[];
  List<List<CouponModel>> finalCoupons;

  final coupons = <CouponModel>[];
  final stores = <String>[];

  String gFav = '';
  String cFav = '';
  String dFav = '';

  getProducts() async {
    print(FirebaseAuth.instance.currentUser.uid);
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      gFav = documentSnapshot.get('giveaway_favorite');
      // cFav = documentSnapshot.data()['coupon_favorite'].toString();
      // dFav = documentSnapshot.data()['deals_favorite'].toString();
    });

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      cFav = documentSnapshot.get('coupon_favorite');
    });

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      dFav = documentSnapshot.get('deals_favorite');
    });

    await FirebaseFirestore.instance
        .collection('Giveaways')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        final s = GiveawayModel(
            image: doc['images'][0],
            title: doc['title'],
            members: doc['members'].toString(),
            duration: '${doc['duration'].toString()} min',
            giveawayId: doc['giveaway_id'],
            rating: doc['total_rating'].toString());
        gFav.split(',').forEach((element) {
          if (s.giveawayId == element) giveaway.add(s);
        });
      });
      setState(() {
        isLoadingGiveaway = false;
      });
    });

    await FirebaseFirestore.instance
        .collection('Products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        final s = ProductsModel(
            images: doc['images'],
            title: doc['title'],
            discount: doc['discount'],
            brand: doc['brand'],
            totalRating: double.parse(doc['total_rating'].toString()),
            reviews: doc['reviews'],
            oldPrice: doc['oldPrice'],
            productID: doc['product_id'],
            newPrice: doc['newPrice']);
        dFav.split(',').forEach((element) {
          if (s.productID == element) deals.add(s);
        });
      });
      setState(() {
        isLoadingProducts = false;
      });
    });

    await FirebaseFirestore.instance
        .collection('Coupons')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        final s = CouponModel(
            couponID: doc['coupon_id'],
            images: doc['images'],
            title: doc['title'],
            newPrice: doc['newPrice'],
            oldPrice: doc['oldPrice'],
            discount: doc['discount'],
            totalRating: doc['total_rating'],
            store: doc['store'],
            brand: doc['brand'],
            backgroundColor: Color(
                int.parse(doc['background_color'].substring(0, 6), radix: 16) +
                    0xFF000000));
        cFav.split(',').forEach((element) {
          if (s.couponID == element) coupons.add(s);
        });
      });
    });

    coupons.forEach((coupon) {
      String store = coupon.store;
      if (!stores.contains(store)) stores.add(store);
    });

    var frequencies = List<int>.filled(stores.length, 0);
    var startingIndex = List<int>.filled(stores.length, 0);
    var startingIndexCopy = List<int>.filled(stores.length, 0);
    var sortedCoupons = List<CouponModel>.filled(coupons.length, CouponModel());

    for (int i = 0; i < coupons.length; i++) {
      for (int j = 0; j < stores.length; j++) {
        if (coupons[i].store == stores[j]) {
          frequencies[j]++;
        }
      }
    }

    for (int i = 1; i < startingIndex.length; i++) {
      startingIndex[i] = startingIndex[i] + frequencies[i - 1];
      startingIndexCopy[i] = startingIndexCopy[i] + frequencies[i - 1];
    }

    for (int i = 0; i < coupons.length; i++) {
      for (int j = 0; j < stores.length; j++) {
        if (coupons[i].store == stores[j]) {
          sortedCoupons[startingIndex[j]] = coupons[i];
          startingIndex[j]++;
        }
      }
    }

    List<List<CouponModel>> f = new List.filled(stores.length, []);
    print(startingIndexCopy);

    for (int i = 0; i < startingIndexCopy.length; i++) {
      if (i != startingIndexCopy.length - 1)
        f[i] = sortedCoupons.sublist(
            startingIndexCopy[i], startingIndexCopy[i + 1]);
      else
        f[i] = sortedCoupons.sublist(startingIndexCopy[i]);
    }

    finalCoupons = f;
    print(finalCoupons);

    setState(() {
      isLoadingCoupon = false;
    });
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                  Widget>[
            Container(
              margin: EdgeInsets.all(15),
              child: Center(
                child: TabBar(
                  isScrollable: true,
                  labelColor: MyColors.PrimaryColor,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelStyle:
                      TextStyle(fontWeight: FontWeight.normal),
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: Colors.grey,
                  indicator: BoxDecoration(
                      color: MyColors.PrimaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15)),
                  tabs: [
                    Container(
                      height: 25.0,
                      child: Tab(
                        child: Text('Giveaway'),
                      ),
                    ),
                    Container(
                      height: 25.0,
                      child: Tab(
                        child: Text('Deals'),
                      ),
                    ),
                    Container(
                      height: 25.0,
                      child: Tab(
                        child: Text('Folders'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                child: TabBarView(children: <Widget>[
              isLoadingGiveaway
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : giveaway.length == 0
                      ? Center(
                          child: Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/empty_favorites.png",
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                  ),
                                  Text('You have no Giveaway favorites',
                                      style: TextStyle(fontSize: 23))
                                ]),
                          ),
                        )
                      : Container(
                          child: ListView.builder(
                            itemCount: giveaway.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.grey.shade400,
                                        width: 0.5)),
                                padding: EdgeInsets.all(13),
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            giveaway[index].image,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              giveaway[index].title,
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Column(
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons.clock,
                                                      color:
                                                          MyColors.PrimaryColor,
                                                      size: 16,
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                        '${giveaway[index].duration}',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14)),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  children: [
                                                    Icon(
                                                      CupertinoIcons.person,
                                                      color:
                                                          MyColors.PrimaryColor,
                                                      size: 16,
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                        '${giveaway[index].members}/5000*',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14)),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Icon(
                                        CupertinoIcons.heart_fill,
                                        color: MyColors.PrimaryColor,
                                        size: 30,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
              isLoadingProducts
                  ? Center(child: CircularProgressIndicator())
                  : giveaway.length == 0
                      ? Center(
                          child: Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/empty_favorites.png",
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                  ),
                                  Text('You have no Deals saved',
                                      style: TextStyle(fontSize: 23))
                                ]),
                          ),
                        )
                      : Container(
                          child: ListView.builder(
                            itemCount: deals.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.grey.shade400,
                                        width: 0.5)),
                                padding: EdgeInsets.all(13),
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Row(
                                  children: [
                                    Image.network(
                                      deals[index].images[0],
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8)),
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${deals[index].title}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                '\$' + deals[index].oldPrice,
                                                style: TextStyle(
                                                    color: Colors.grey.shade400,
                                                    fontSize: 16,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '\$' + deals[index].newPrice,
                                                style: TextStyle(
                                                  color: MyColors.PrimaryColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: Colors.green
                                                        .withOpacity(0.15)),
                                                child: Center(
                                                  child: Text(
                                                    deals[index].discount +
                                                        '% OFF',
                                                    style: TextStyle(
                                                        color: MyColors
                                                            .PrimaryColor,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                deals[index]
                                                    .totalRating
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              RatingBarIndicator(
                                                rating: double.parse(
                                                    deals[index]
                                                        .totalRating
                                                        .toString()),
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
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Brand:',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                deals[index].brand,
                                                style: TextStyle(
                                                    color:
                                                        MyColors.PrimaryColor),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
              isLoadingCoupon
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : giveaway.length == 0
                      ? Center(
                          child: Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/empty_favorites.png",
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                  ),
                                  Text('No Coupons found',
                                      style: TextStyle(fontSize: 23))
                                ]),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: stores.length,
                            itemBuilder: (context, index2) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(stores[index2],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          )),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                finalCoupons[index2].length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade400,
                                                        width: 0.5)),
                                                padding: EdgeInsets.all(13),
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                child: Row(
                                                  children: [
                                                    Image.network(
                                                      finalCoupons[index2]
                                                              [index]
                                                          .images[0],
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        8),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            8)),
                                                        color: Colors.white,
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '${finalCoupons[index2][index].title}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            children: <Widget>[
                                                              Text(
                                                                '\$' +
                                                                    finalCoupons[index2]
                                                                            [
                                                                            index]
                                                                        .oldPrice,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade400,
                                                                    fontSize:
                                                                        16,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                '\$' +
                                                                    finalCoupons[index2]
                                                                            [
                                                                            index]
                                                                        .newPrice,
                                                                style:
                                                                    TextStyle(
                                                                  color: MyColors
                                                                      .PrimaryColor,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                8),
                                                                    color: Colors
                                                                        .green
                                                                        .withOpacity(
                                                                            0.15)),
                                                                child: Center(
                                                                  child: Text(
                                                                    finalCoupons[index2][index]
                                                                            .discount +
                                                                        '% OFF',
                                                                    style: TextStyle(
                                                                        color: MyColors
                                                                            .PrimaryColor,
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                finalCoupons[
                                                                            index2]
                                                                        [index]
                                                                    .totalRating
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              RatingBarIndicator(
                                                                rating: double.parse(finalCoupons[
                                                                            index2]
                                                                        [index]
                                                                    .totalRating
                                                                    .toString()),
                                                                itemBuilder:
                                                                    (context,
                                                                            index) =>
                                                                        Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .amber,
                                                                ),
                                                                itemCount: 5,
                                                                itemSize: 15.0,
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'Brand:',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                finalCoupons[
                                                                            index2]
                                                                        [index]
                                                                    .brand,
                                                                style: TextStyle(
                                                                    color: MyColors
                                                                        .PrimaryColor),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      )
                                    ]),
                              );
                            },
                          ),
                        ),
            ]))
          ])),
    );
  }
}
