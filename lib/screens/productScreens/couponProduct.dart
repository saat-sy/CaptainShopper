import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/models/coupon_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CouponProductScreen extends StatefulWidget {
  String couponID;
  CouponProductScreen({this.couponID});
  @override
  _CouponProductScreenState createState() => _CouponProductScreenState();
}

class _CouponProductScreenState extends State<CouponProductScreen> {
  bool isLoading = true;

  CouponModel coupon = CouponModel();

  bool inFav = false;

  showQrDialog(BuildContext context, String data) {
    AlertDialog alert = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 300,
            width: 300,
            child: QrImage(
              data: data,
              version: QrVersions.auto,
              size: 200,
            ),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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

  Future<String> getUserFavs() async {
    String val;
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      val = documentSnapshot.get('coupon_favorite');
    }).catchError((e) {
      print(e);
      val = 'An error occured';
    });
    return val;
  }

  getCouponProducts() async {
    FirebaseFirestore.instance
        .collection('Coupons')
        .where('coupon_id', isEqualTo: widget.couponID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        coupon = CouponModel(
            images: doc['images'],
            title: doc['title'],
            discount: doc['discount'],
            brand: doc['brand'],
            totalRating: doc['total_rating'],
            reviews: doc['reviews'],
            oldPrice: doc['oldPrice'],
            couponID: doc['coupon_id'],
            usernames: doc['usernames'],
            ratings: doc['ratings'],
            description: doc['description'],
            storeLocation: doc['store_location'],
            store: doc['store'],
            time: doc['time'],
            newPrice: doc['newPrice'],
            backgroundColor: Color(
                int.parse(doc['background_color'].substring(0, 6), radix: 16) +
                    0xFF000000));
      });
    });
    String isFav = await getUserFavs();
    if (isFav != "An error occured")
      isFav.split(',').forEach((product) {
        if (product == widget.couponID) inFav = true;
      });

    setState(() {
      isLoading = false;
    });
  }

  Future<void> addToFav() async {
    showLoaderDialog(context);

    String val = '';

    String favs = await getUserFavs();
    if (favs != "") favs += ',';
    if (favs == 'An error occured') {
      val = 'An error occured';
    }

    if (val == '') {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({'coupon_favorite': favs + widget.couponID})
          .then((value) => val = 'Added to Favorites')
          .catchError((e) {
            val = 'An error occured';
            print(e);
          });
    }

    final snackBar = SnackBar(content: Text(val));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    if (val != 'An error occured')
      setState(() {
        inFav = true;
      });
    Navigator.pop(context);
  }

  Future<void> removeFromFav() async {
    showLoaderDialog(context);

    String val = '';

    String favs = await getUserFavs();
    if (favs == 'An error occured') {
      val = 'An error occured';
    }

    if (val == '') {
      String newFavs = '';
      favs.split(',').forEach((element) {
        if (element != widget.couponID) {
          if (newFavs != '')
            newFavs += ',$element';
          else
            newFavs += element;
        }
      });
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({'coupon_favorite': newFavs})
          .then((value) => val = 'Removed from Favorites')
          .catchError((e) {
            val = 'An error occured';
            print(e);
          });
    }

    final snackBar = SnackBar(content: Text(val));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    if (val != 'An error occured')
      setState(() {
        inFav = false;
      });
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  void initState() {
    getCouponProducts();
    super.initState();
  }

  List<String> relatedImages = [
    'assets/products/product2.png',
    'assets/products/product1.png',
    'assets/products/product2.png',
    'assets/products/product1.png',
    'assets/products/product2.png',
    'assets/products/product1.png',
  ];

  List<Color> relatedColors = [
    Color(0xFF5C4D93),
    Color(0xFFD37C79),
    Color(0xFF5C4D93),
    Color(0xFFD37C79),
    Color(0xFF5C4D93),
    Color(0xFFD37C79),
  ];

  int activeMedia = 0;

  final imageController = PageController();

  animateToIndex(int index) {
    imageController.animateToPage(index,
        duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              child: isLoading
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          color: coupon.backgroundColor,
                          child: Stack(
                            children: [
                              PageView.builder(
                                onPageChanged: (index) {
                                  setState(() {
                                    activeMedia = index;
                                  });
                                },
                                controller: imageController,
                                itemCount: (coupon.images).length,
                                itemBuilder: (context, index) {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                      child: Image.network(
                                        coupon.images[activeMedia],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                              Icons.arrow_back,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                        IconButton(
                                            icon: Icon(
                                              Icons.share,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {})
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height * 0.11,
                            color: Colors.grey.shade200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: coupon.images.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      activeMedia = index;
                                      animateToIndex(index);
                                    });
                                  },
                                  child: Container(
                                    width: 80,
                                    padding: EdgeInsets.all(8),
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          width: index == activeMedia ? 2 : 1,
                                          color: index == activeMedia
                                              ? MyColors.PrimaryColor
                                              : Colors.grey.shade200),
                                      color: coupon.backgroundColor,
                                    ),
                                    child: Image.network(
                                      coupon.images[index],
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                    ),
                                  ),
                                );
                              },
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    coupon.title,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    icon: inFav
                                        ? Icon(
                                            Icons.favorite,
                                            color: Colors.pinkAccent.shade400,
                                          )
                                        : Icon(Icons.favorite_outline),
                                    onPressed: () async {
                                      if (inFav)
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text('Remove coupon?'),
                                            content: const Text(
                                                'Do you want to remove this coupon from favorites?'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('No'),
                                              ),
                                              TextButton(
                                                onPressed: () async =>
                                                    await removeFromFav(),
                                                child: const Text('Yes'),
                                              ),
                                            ],
                                          ),
                                        );
                                      else
                                        await addToFav();
                                    },
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    '\$' + coupon.oldPrice,
                                    style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 21,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '\$' + coupon.newPrice,
                                    style: TextStyle(
                                      color: MyColors.PrimaryColor,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.green.withOpacity(0.15)),
                                    child: Center(
                                      child: Text(
                                        coupon.discount + '% OFF',
                                        style: TextStyle(
                                            color: MyColors.PrimaryColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
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
                                    coupon.totalRating,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  RatingBarIndicator(
                                    rating: double.parse(coupon.totalRating),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 15.0,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '(${coupon.ratings.length} Ratings)',
                                    style:
                                        TextStyle(color: Colors.grey.shade400),
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
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    coupon.brand,
                                    style:
                                        TextStyle(color: MyColors.PrimaryColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    CupertinoIcons.clock,
                                    color: MyColors.PrimaryColor,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(coupon.time,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16)),
                                  Text('Time left',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14))
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Icon(
                                    CupertinoIcons.location,
                                    color: MyColors.PrimaryColor,
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text('Store: ${coupon.store}',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.5)),
                                  Text('Get Directions',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14))
                                ],
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showQrDialog(
                                context,
                                coupon.couponID +
                                    ',' +
                                    FirebaseAuth.instance.currentUser.uid);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 4),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: MyColors.PrimaryColor,
                                borderRadius: BorderRadius.circular(6)),
                            child: Center(
                              child: Text(
                                'Redeem your Coupon',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: MyColors.PrimaryColor, width: 1.5),
                              borderRadius: BorderRadius.circular(6)),
                          child: Center(
                            child: Text(
                              'Save it',
                              style: TextStyle(
                                  color: MyColors.PrimaryColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            'Description',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            coupon.description,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            'Related Coupons',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 11),
                          height: 250,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: relatedImages.length,
                            itemBuilder: (context, index) {
                              return Container(
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
                                          color: relatedColors[index],
                                        ),
                                        padding: EdgeInsets.all(15),
                                        child: Center(
                                          child: Image(
                                            height: 75,
                                            image: AssetImage(
                                                relatedImages[index]),
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
                                                    '5.0',
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  RatingBarIndicator(
                                                    rating: 5,
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
                                                    '(6,256 Ratings)',
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
                                                    '\$' + '199.99',
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
                                                    '\$' + '68.99',
                                                    style: TextStyle(
                                                      color:
                                                          MyColors.PrimaryColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color: Colors.green
                                                            .withOpacity(0.15)),
                                                    child: Center(
                                                      child: Text(
                                                        '75' + '% OFF',
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
                                                '5 Packs of SuperFruit Barries',
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
                                                    'Candy Cane',
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
                                  ));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            'Reviews',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: coupon.reviews.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        coupon.usernames[index],
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 13),
                                      ),
                                      RatingBarIndicator(
                                        rating: double.parse(
                                            coupon.ratings[index].toString()),
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 13.0,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        coupon.reviews[index],
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    )),
        ),
      ),
    );
  }
}
