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
  List<CouponModel> coupon = [
    CouponModel(
      title: 'Superfruit Berries',
      color: Color(0xFFD37C79),
      image: 'assets/products/product1.png'
    ),
    CouponModel(
      title: 'Happy Faces',
      color: Color(0xFF5C4D93),
      image: 'assets/products/product2.png'
    ),
    CouponModel(
      title: 'Superfruit Berries',
      color: Color(0xFFD37C79),
      image: 'assets/products/product1.png'
    ),
    CouponModel(
      title: 'Happy Faces',
      color: Color(0xFF5C4D93),
      image: 'assets/products/product2.png'
    ),
    CouponModel(
      title: 'Superfruit Berries',
      color: Color(0xFFD37C79),
      image: 'assets/products/product1.png'
    ),
    CouponModel(
      title: 'Happy Faces',
      color: Color(0xFF5C4D93),
      image: 'assets/products/product2.png'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListView.builder(
          itemCount: coupon.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CouponProductScreen()));
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
                        color: coupon[index].color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image(
                              width: MediaQuery.of(context).size.width * 0.23,
                              image: AssetImage(coupon[index].image),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      coupon[index].title,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      'Brand: CandyPlus',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      'Store: CVS',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    RatingBarIndicator(
                                      rating: 5,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 15.0,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          '75%',
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
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '+',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 25),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          '\$100',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Giveaway',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
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
                              'Valid until 3rd August, 2021',
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
