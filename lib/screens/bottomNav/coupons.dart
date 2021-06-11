import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/models/coupon_model.dart';
import 'package:frontend/screens/productScreens/couponProduct.dart';

class Coupons extends StatefulWidget {
  @override
  _CouponsState createState() => _CouponsState();
}

class _CouponsState extends State<Coupons> {

  bool isLoading = true;

  final coupons = <CouponModel>[];

  getGiveAwayProducts() async {
    FirebaseFirestore.instance
        .collection('Coupons')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        final s = CouponModel(
            couponID: doc['coupon_id'],
            images: doc['images'],
            title: doc['title'],
            brand: doc['brand'],
            store: doc['store'],
            validTill: doc['valid_till'],
            discount: doc['discount'],
            totalRating: doc['total_rating'],
            backgroundColor: Color(int.parse(doc['background_color'].substring(0, 6), radix: 16) + 0xFF000000));
        coupons.add(s);
      });
      setState(() {
        isLoading = false;
      });
    });
  }


  @override
  void initState() {
    getGiveAwayProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: isLoading
        ? Center(
          child: CircularProgressIndicator(),
        ) : 
      Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListView.builder(
          itemCount: coupons.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CouponProductScreen(couponID: coupons[index].couponID,)));
              },
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        offset: Offset(0, 4),
                        blurRadius: 3.0,
                        spreadRadius: 1.0)
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: new BoxDecoration(
                        color: coupons[index].backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              coupons[index].images[0],
                              width: MediaQuery.of(context).size.width * 0.23,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      coupons[index].title,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      'Brand: ${coupons[index].brand}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      'Store: ${coupons[index].store}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    RatingBarIndicator(
                                      rating: double.parse(coupons[index].totalRating),
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 15.0,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '${coupons[index].discount}%',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'OFF',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Valid until ${coupons[index].validTill}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: MyColors.PrimaryColor,
                              ),
                              child: Text(
                                'Redeem',
                                style: TextStyle(color: Colors.white, fontSize: 13),
                              ),
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
    );
  }
}
