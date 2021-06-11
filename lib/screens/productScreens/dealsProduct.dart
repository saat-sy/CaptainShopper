import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/models/products_model.dart';
import 'package:frontend/screens/order/placeOrder.dart';

class DealsProductScreen extends StatefulWidget {
  String productID;
  DealsProductScreen({this.productID});

  @override
  _DealsProductScreenState createState() => _DealsProductScreenState();
}

class _DealsProductScreenState extends State<DealsProductScreen> {
  bool isLoading = true;
  bool inFav = false;
  bool inCart = false;

  ProductsModel deal = ProductsModel();

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
      val = documentSnapshot.get('deals_favorite');
    }).catchError((e) {
      print(e);
      val = 'An error occured';
    });
    return val;
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

  getGiveAwayProducts() async {
    await FirebaseFirestore.instance
        .collection('Products')
        .where('product_id', isEqualTo: widget.productID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        deal = ProductsModel(
            images: doc['images'],
            title: doc['title'],
            discount: doc['discount'],
            brand: doc['brand'],
            totalRating: double.parse(doc['total_rating'].toString()),
            reviews: doc['reviews'],
            oldPrice: doc['oldPrice'],
            productID: doc['product_id'],
            usernames: doc['usernames'],
            ratings: doc['ratings'],
            description: doc['description'],
            newPrice: doc['newPrice']);
      });
    });

    String isFav = await getUserFavs();
    if (isFav != "An error occured")
      isFav.split(',').forEach((product) {
        if (product == widget.productID) inFav = true;
      });

    String isinCart = await getUserCart();
    if (isinCart != "An error occured")
      isinCart.split(',').forEach((product) {
        print(product);
        if (product.split(':')[0] == widget.productID) inCart = true;
      });

    setState(() {
      isLoading = false;
    });
  }

  Future<void> addToCart() async {
    showLoaderDialog(context);

    String val = '';

    String cart = await getUserCart();
    if (cart != "") cart += ',';
    if (cart == 'An error occured') {
      val = 'An error occured';
    }

    if (val == '') {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({'cart': cart + widget.productID + ':1'})
          .then((value) => val = 'Added to Cart!')
          .catchError((e) {
            val = 'An error occured';
            print(e);
          });
    }

    final snackBar = SnackBar(content: Text(val));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    if (val != 'An error occured')
      setState(() {
        inCart = true;
      });
    Navigator.pop(context);
  }

  Future<void> removeFromCart() async {
    showLoaderDialog(context);

    String val = '';

    String cart = await getUserCart();
    if (cart == 'An error occured') {
      val = 'An error occured';
    }

    if (val == '') {
      String newCart = '';
      cart.split(',').forEach((element) {
        if (element.split(':')[0] != widget.productID) {
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

    if (val != 'An error occured')
      setState(() {
        inCart = false;
      });
    Navigator.pop(context);
    Navigator.pop(context);
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
          .update({'deals_favorite': favs + widget.productID})
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
        if (element != widget.productID) {
          if (newFavs != '')
            newFavs += ',$element';
          else
            newFavs += element;
        }
      });
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({'deals_favorite': newFavs})
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
    getGiveAwayProducts();
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

  int activeMedia = 0;

  final imageController = PageController();

  animateToIndex(int index) {
    imageController.animateToPage(index,
        duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
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
                          color: Colors.grey.shade50,
                          child: Stack(
                            children: [
                              PageView.builder(
                                onPageChanged: (index) {
                                  setState(() {
                                    activeMedia = index;
                                  });
                                },
                                controller: imageController,
                                itemCount: (deal.images).length,
                                itemBuilder: (context, index) {
                                  return Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0),
                                      child: Image.network(
                                        deal.images[activeMedia],
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
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                        IconButton(
                                            icon: Icon(
                                              Icons.share,
                                              color: Colors.black,
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
                              itemCount: deal.images.length,
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
                                      color: Colors.grey.shade50,
                                    ),
                                    child: Image.network(
                                      deal.images[index],
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
                                    deal.title,
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
                                            title:
                                                const Text('Remove product?'),
                                            content: const Text(
                                                'Do you want to remove this item from favorites?'),
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
                                    '\$' + deal.oldPrice,
                                    style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 21,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '\$' + deal.newPrice,
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
                                        deal.discount + '% OFF',
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
                                    deal.totalRating.toString(),
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  RatingBarIndicator(
                                    rating: deal.totalRating.toDouble(),
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
                                    '(${deal.ratings.length} Ratings)',
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
                                    deal.brand,
                                    style:
                                        TextStyle(color: MyColors.PrimaryColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        // Container(
                        //   margin:
                        //       EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                        //   padding:
                        //       EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        //   decoration: BoxDecoration(
                        //       border:
                        //           Border.all(color: Colors.black, width: 0.5),
                        //       borderRadius: BorderRadius.circular(6)),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(
                        //         'Style: \nNew',
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.w700, fontSize: 16),
                        //       ),
                        //       Icon(
                        //         Icons.arrow_forward_ios,
                        //         size: 18,
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   margin:
                        //       EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                        //   padding:
                        //       EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        //   decoration: BoxDecoration(
                        //       border:
                        //           Border.all(color: Colors.black, width: 0.5),
                        //       borderRadius: BorderRadius.circular(6)),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(
                        //         '3 colors: \nReal Flowers',
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.w700, fontSize: 16),
                        //       ),
                        //       Icon(
                        //         Icons.arrow_forward_ios,
                        //         size: 18,
                        //       )
                        //     ],
                        //   ),
                        // ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlaceOrder(
                                    products: deal.productID,
                                    subtotal: deal.newPrice,
                                  )));
                          },
                          child: Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: MyColors.PrimaryColor,
                                borderRadius: BorderRadius.circular(6)),
                            child: Center(
                              child: Text(
                                'Buy Now',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            if (inCart)
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Remove product?'),
                                  content: const Text(
                                      'Do you want to remove this item from cart?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () async =>
                                          await removeFromCart(),
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                ),
                              );
                            else
                              await addToCart();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 4),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: MyColors.PrimaryColor, width: 1.5),
                                borderRadius: BorderRadius.circular(6)),
                            child: Center(
                              child: Text(
                                !inCart ? 'Add to Cart' : 'In your Cart',
                                style: TextStyle(
                                    color: MyColors.PrimaryColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
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
                            deal.description,
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
                                            color: Colors.white),
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
                              itemCount: deal.reviews.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        deal.usernames[index],
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 13),
                                      ),
                                      RatingBarIndicator(
                                        rating: double.parse(
                                            deal.ratings[index].toString()),
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
                                        deal.reviews[index],
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
