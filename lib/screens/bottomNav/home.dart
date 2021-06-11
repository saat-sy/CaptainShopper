import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/models/coupon_model.dart';
import 'package:frontend/models/products_model.dart';
import 'package:frontend/models/giveaway_model.dart';
import 'package:frontend/screens/bottomNav/bottomNav.dart';
import 'package:frontend/screens/productScreens/couponProduct.dart';
import 'package:frontend/screens/productScreens/dealsProduct.dart';
import 'package:frontend/screens/productScreens/giveawayProductScreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoadingGiveaway = true;
  bool isLoadingProducts = true;
  bool isLoadingCoupon = true;

  final giveaway = <GiveawayModel>[];
  final products = <ProductsModel>[];
  final coupons = <CouponModel>[];

  getProducts() async {
    await FirebaseFirestore.instance
        .collection('Giveaways')
        .limit(6)
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
        giveaway.add(s);
      });
      setState(() {
        isLoadingGiveaway = false;
      });
    });

    await FirebaseFirestore.instance
        .collection('Products')
        .limit(6)
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
        products.add(s);
      });
      setState(() {
        isLoadingProducts = false;
      });
    });

    FirebaseFirestore.instance
        .collection('Coupons')
        .limit(6)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        final s = CouponModel(
            couponID: doc['coupon_id'],
            images: doc['images'],
            title: doc['title'],
            newPrice: doc['newPrice'],
            discount: doc['discount'],
            totalRating: doc['total_rating'],
            backgroundColor: Color(
                int.parse(doc['background_color'].substring(0, 6), radix: 16) +
                    0xFF000000));
        coupons.add(s);
      });
      setState(() {
        isLoadingCoupon = false;
      });
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
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Welcome back, ${FirebaseAuth.instance.currentUser.displayName}',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'How are you doing?',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'News',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 70,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNav(
                                          index: 0,
                                        )));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: MyColors.PrimaryColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Peter won \$1000',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Yesterday giveaway winner',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  MdiIcons.gift,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Popular Giveaways',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNav(
                                        index: 0,
                                      )));
                        },
                        child: Text(
                          'View all',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                  isLoadingGiveaway
                      ? Container(
                          height: 165,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : InkWell(
                          child: Container(
                            height: 165,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: giveaway.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GiveawayProduct(
                                              id: giveaway[index].giveawayId,
                                            )));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Container(
                                        child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            giveaway[index].image,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                giveaway[index].title,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Icon(Icons.person,
                                                          color: Colors.white,
                                                          size: 17),
                                                      Text(
                                                        giveaway[index].members,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Icon(
                                                        MdiIcons.clock,
                                                        color: Colors.white,
                                                        size: 17,
                                                      ),
                                                      Text(
                                                        giveaway[index].duration,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.star,
                                                      color: Colors.amber,
                                                      size: 17),
                                                  SizedBox(
                                                    width: 2,
                                                  ),
                                                  Text(
                                                    giveaway[index].rating,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5),
                                                        color:
                                                            MyColors.PrimaryColor,
                                                        border: Border.all(
                                                            color: MyColors
                                                                .PrimaryColor)),
                                                    child: Center(
                                                      child: Text(
                                                        'Watch Now',
                                                        style: TextStyle(
                                                            color: Colors.white),
                                                      ),
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
                                                                5),
                                                        color: Colors.white
                                                            .withOpacity(0),
                                                        border: Border.all(
                                                            color: Colors.white)),
                                                    child: Center(
                                                      child: Text(
                                                        'View Details',
                                                        style: TextStyle(
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Top Deals',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNav(
                                        index: 3,
                                      )));
                        },
                        child: Text(
                          'View all',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                  InkWell(
                    child: Container(
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: coupons.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CouponProductScreen(
                                        couponID: coupons[index].couponID,
                                      )));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              decoration: BoxDecoration(
                                  color: coupons[index].backgroundColor,
                                  borderRadius: BorderRadius.circular(8)),
                              margin: EdgeInsets.only(right: 10),
                              child: Container(
                                  child: Container(
                                padding:
                                    EdgeInsets.only(top: 20, left: 20, right: 20),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 150,
                                            child: Text(
                                              coupons[index].title.toUpperCase(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.star,
                                                  color: Colors.amber, size: 17),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text(
                                                coupons[index].totalRating,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '\$${coupons[index].newPrice}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 21),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 3.0),
                                                child: Text(
                                                  'OFF ${coupons[index].discount}%',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: MyColors.PrimaryColor,
                                                border: Border.all(
                                                    color:
                                                        MyColors.PrimaryColor)),
                                            child: Center(
                                              child: Text(
                                                'Add to Cart',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Image.network(
                                      coupons[index].images[0],
                                      width:
                                          MediaQuery.of(context).size.width * 0.2,
                                    )
                                  ],
                                ),
                              )),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'More Deals',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNav(
                                        index: 3,
                                      )));
                        },
                        child: Text(
                          'View all',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                  isLoadingProducts
                      ? Container(
                          height: 240,
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : Container(
                        height: 240,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DealsProductScreen(
                                              productID: products[index].productID,
                                            )));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          offset: Offset(0, 4),
                                          blurRadius: 3.0,
                                          spreadRadius: 1.0)
                                    ],
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 8),
                                  width: 200,
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding: EdgeInsets.all(15),
                                        child: Center(
                                          child: Image.network(
                                            products[index].images[0],
                                            height: 75,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, top: 7),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    products[index]
                                                        .totalRating
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  RatingBarIndicator(
                                                    rating: products[index]
                                                        .totalRating
                                                        .toDouble(),
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    itemCount: 5,
                                                    itemSize: 13.0,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    '(${products[index].reviews.length} Ratings)',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade400),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    '\$' +
                                                        products[index]
                                                            .oldPrice,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade400,
                                                        fontSize: 16,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    '\$' +
                                                        products[index]
                                                            .newPrice,
                                                    style: TextStyle(
                                                      color: MyColors
                                                          .PrimaryColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color: Colors.green
                                                            .withOpacity(
                                                                0.15)),
                                                    child: Center(
                                                      child: Text(
                                                        products[index]
                                                                .discount +
                                                            '% OFF',
                                                        style: TextStyle(
                                                            color: MyColors
                                                                .PrimaryColor,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                products[index].title,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Sold By:',
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    products[index].brand,
                                                    style: TextStyle(
                                                        color: MyColors
                                                            .PrimaryColor),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            );
                          },
                        ),
                      ),
                ],
              ),
            ),
          )),
    );
  }
}
