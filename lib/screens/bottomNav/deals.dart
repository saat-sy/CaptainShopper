import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/models/products_model.dart';
import 'package:frontend/screens/productScreens/dealsProduct.dart';

class Deals extends StatefulWidget {
  @override
  _DealsState createState() => _DealsState();
}

class _DealsState extends State<Deals> {

  bool isLoading = true;

  final deals = <ProductsModel>[];

  getDeals() async {
    FirebaseFirestore.instance
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
        deals.add(s);
      });
      setState(() {
        isLoading = false;
      });
    });
  }


  @override
  void initState() {
    getDeals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: isLoading ?
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ) :
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),
            Text('Trending Deals', 
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 3,),
            Expanded(
              child: ListView.builder(
                itemCount: deals.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DealsProductScreen(
                        productID: deals[index].productID,
                      )));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              offset: Offset(0, 2),
                              blurRadius: 5.0,
                              spreadRadius: 1.0)
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    deals[index].images[0],
                                    width: MediaQuery.of(context).size.width * 0.3,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      deals[index].discount + "%",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold
                                      )
                                    ),
                                    Text(
                                      'OFF',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold
                                      )
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    deals[index].title,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
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
                                            fontSize: 21,
                                            decoration: TextDecoration.lineThrough),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '\$' + deals[index].newPrice,
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
                                            deals[index].discount + '% OFF',
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                deals[index].totalRating.toString(),
                                                style: TextStyle(color: Colors.grey),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              RatingBarIndicator(
                                                rating: deals[index].totalRating,
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
                                                '(${deals[index].reviews.length} Ratings)',
                                                style: TextStyle(color: Colors.grey.shade400),
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
                                                deals[index].brand,
                                                style: TextStyle(color: MyColors.PrimaryColor),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: MyColors.PrimaryColor,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          'Buy Now',
                                          style: TextStyle(
                                            color: Colors.white
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}