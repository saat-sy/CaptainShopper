import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/models/coupon_model.dart';
import 'package:frontend/models/giveaway_model.dart';
import 'package:frontend/screens/bottomNav/bottomNav.dart';
import 'package:frontend/screens/productScreens/dealsProduct.dart';
import 'package:frontend/screens/productScreens/giveawayProductScreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<GiveawayModel> giveaway = [
    GiveawayModel(
        image: 'assets/products/giveaway/PS5.jpg',
        title: '\'Win\' PS 5 Console',
        members: '4,756',
        duration: '5 min',
        rating: '5.0'),
    GiveawayModel(
        image: 'assets/products/giveaway/iPhone.png',
        title: '\'Win\' iPhone 6',
        members: '3,222',
        duration: '5 min',
        rating: '5.0'),
    GiveawayModel(
        image: 'assets/products/giveaway/PS5.jpg',
        title: '\'Win\' PS 5 Console',
        members: '5,345',
        duration: '5 min',
        rating: '5.0'),
    GiveawayModel(
        image: 'assets/products/giveaway/iPhone.png',
        title: '\'Win\' iPhone 6',
        members: '4,125',
        duration: '5 min',
        rating: '5.0'),
    GiveawayModel(
        image: 'assets/products/giveaway/PS5.jpg',
        title: '\'Win\' PS 5 Console',
        members: '3,316',
        duration: '5 min',
        rating: '5.0'),
    GiveawayModel(
        image: 'assets/products/giveaway/iPhone.png',
        title: '\'Win\' iPhone 6',
        members: '3,945',
        duration: '5 min',
        rating: '5.0'),
  ];

  List<CouponModel> coupon = [
    CouponModel(
        title: 'Superfruit Berries',
        color: Color(0xFFD37C79),
        image: 'assets/products/product1.png'),
    CouponModel(
        title: 'Happy \nFaces',
        color: Color(0xFF5C4D93),
        image: 'assets/products/product2.png'),
    CouponModel(
        title: 'Superfruit Berries',
        color: Color(0xFFD37C79),
        image: 'assets/products/product1.png'),
    CouponModel(
        title: 'Happy \nFaces',
        color: Color(0xFF5C4D93),
        image: 'assets/products/product2.png'),
    CouponModel(
        title: 'Superfruit Berries',
        color: Color(0xFFD37C79),
        image: 'assets/products/product1.png'),
    CouponModel(
        title: 'Happy \nFaces',
        color: Color(0xFF5C4D93),
        image: 'assets/products/product2.png'),
  ];

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
                    'Welcome back, Peter',
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNav(index: 0,)));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding:
                                EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNav(index: 0,)));
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GiveawayProduct()));
                    },
                    child: Container(
                      height: 165,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: giveaway.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Container(
                                child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image(
                                    image: AssetImage(giveaway[index].image),
                                    width: MediaQuery.of(context).size.width * 0.7,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  color: Colors.white, size: 17),
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
                                              color: Colors.amber, size: 17),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            giveaway[index].rating,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 13),
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
                                                    BorderRadius.circular(5),
                                                color: MyColors.PrimaryColor,
                                                border: Border.all(
                                                    color: MyColors.PrimaryColor)),
                                            child: Center(
                                              child: Text(
                                                'Watch Now',
                                                style:
                                                    TextStyle(color: Colors.white),
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
                                                    BorderRadius.circular(5),
                                                color: Colors.white.withOpacity(0),
                                                border: Border.all(
                                                    color: Colors.white)),
                                            child: Center(
                                              child: Text(
                                                'View Details',
                                                style:
                                                    TextStyle(color: Colors.white),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNav(index: 3,)));
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DealsProductScreen()));
                    },
                    child: Container(
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: giveaway.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(
                                color: coupon[index].color,
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 150,
                                          child: Text(
                                            coupon[index].title.toUpperCase(),
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
                                              giveaway[index].rating,
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
                                              '\$24',
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
                                                'OFF 50%',
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
                                                  color: MyColors.PrimaryColor)),
                                          child: Center(
                                            child: Text(
                                              'Add to Cart',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Image(
                                    image: AssetImage(coupon[index].image),
                                    width: MediaQuery.of(context).size.width * 0.2,
                                  )
                                ],
                              ),
                            )),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNav(index: 3,)));
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DealsProductScreen()));
                    },
                    child: Container(
                      height: 240,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: coupon.length,
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
                              margin:
                                  EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                              width: 200,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: coupon[index].color,
                                    ),
                                    padding: EdgeInsets.all(15),
                                    child: Center(
                                      child: Image(
                                        height: 75,
                                        image: AssetImage(coupon[index].image),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 5.0, top: 7),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                '5.0',
                                                style:
                                                    TextStyle(color: Colors.grey),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              RatingBarIndicator(
                                                rating: 5,
                                                itemBuilder: (context, index) =>
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
                                                    color: Colors.grey.shade400),
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
                                                    color: Colors.grey.shade400,
                                                    fontSize: 16,
                                                    decoration:
                                                        TextDecoration.lineThrough),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '\$' + '68.99',
                                                style: TextStyle(
                                                  color: MyColors.PrimaryColor,
                                                  fontSize: 16,
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
                                                        BorderRadius.circular(8),
                                                    color: Colors.green
                                                        .withOpacity(0.15)),
                                                child: Center(
                                                  child: Text(
                                                    '75' + '% OFF',
                                                    style: TextStyle(
                                                        color:
                                                            MyColors.PrimaryColor,
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Sold By:',
                                                style:
                                                    TextStyle(color: Colors.grey),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Candy Cane',
                                                style: TextStyle(
                                                    color: MyColors.PrimaryColor),
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
                  ),
                  // Container(
                  //   height: 250,
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: allProducts.length,
                  //     itemBuilder: (context, index) {
                  //       return Container(
                  //         width: 150,
                  //         margin: EdgeInsets.symmetric(
                  //             vertical: 8, horizontal: 2),
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.grey.shade300,
                  //               offset: Offset(0.0, 1.0),
                  //               blurRadius: 4.0,
                  //             ),
                  //           ],
                  //         ),
                  //         child: Column(
                  //           children: <Widget>[
                  //             Image(
                  //               image:
                  //                   AssetImage(allProducts[index].imagePath),
                  //               height: 100,
                  //             ),
                  //             SizedBox(
                  //               height: 10,
                  //             ),
                  //             Text(
                  //               allProducts[index].title,
                  //               style: TextStyle(
                  //                   color: Colors.black,
                  //                   fontSize: 18,
                  //                   fontWeight: FontWeight.bold),
                  //             ),
                  //             SizedBox(
                  //               height: 5,
                  //             ),
                  //             Row(
                  //               crossAxisAlignment: CrossAxisAlignment.center,
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Text(
                  //                   allProducts[index].rating.toString(),
                  //                   style: TextStyle(
                  //                       color: Colors.grey,
                  //                       fontSize: 13,
                  //                       fontWeight: FontWeight.w600),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 4,
                  //                 ),
                  //                 RatingBarIndicator(
                  //                   rating: allProducts[index].rating,
                  //                   itemBuilder: (context, index) => Icon(
                  //                     Icons.star,
                  //                     color: Colors.amber,
                  //                   ),
                  //                   itemCount: 5,
                  //                   itemSize: 15.0,
                  //                 ),
                  //               ],
                  //             ),
                  //             SizedBox(
                  //               height: 5,
                  //             ),
                  //             Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: <Widget>[
                  //                 Text(
                  //                   '\$' +
                  //                       allProducts[index]
                  //                           .old_price
                  //                           .toString(),
                  //                   style: TextStyle(
                  //                       color: Colors.grey.shade400,
                  //                       fontSize: 16,
                  //                       decoration:
                  //                           TextDecoration.lineThrough),
                  //                 ),
                  //                 SizedBox(
                  //                   width: 5,
                  //                 ),
                  //                 Text(
                  //                   '\$' +
                  //                       allProducts[index]
                  //                           .new_price
                  //                           .toString(),
                  //                   style: TextStyle(
                  //                     color: MyColors.PrimaryColor,
                  //                     fontSize: 16,
                  //                     fontWeight: FontWeight.bold,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //             SizedBox(
                  //               height: 10,
                  //             ),
                  //             Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 InkWell(
                  //                   onTap: () {},
                  //                   child: Container(
                  //                     padding: EdgeInsets.symmetric(
                  //                         horizontal: 20, vertical: 5),
                  //                     decoration: BoxDecoration(
                  //                         borderRadius:
                  //                             BorderRadius.circular(5),
                  //                         color: MyColors.PrimaryColor),
                  //                     child: Center(
                  //                       child: Text(
                  //                         'Add to Cart',
                  //                         style: TextStyle(
                  //                             color: Colors.white,
                  //                             fontWeight: FontWeight.w700,
                  //                             fontSize: 12),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 )
                  //               ],
                  //             )
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 25,
                  // )
                ],
              ),
            ),
          )),
    );
  }
}
