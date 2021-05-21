import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/authentication/login.dart';
import 'package:frontend/screens/bottomNav/bottomNav.dart';
import 'package:frontend/screens/profile/claim_your_wins.dart';
import 'package:frontend/screens/profile/customer_service.dart';
import 'package:frontend/screens/profile/orders.dart';
import 'package:frontend/screens/profile/rewards.dart';
import 'package:frontend/screens/profile/settings.dart';
import 'package:frontend/screens/profile/write_a_review.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../colors.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: MyColors.PrimaryColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
            ),
            height: 75 + (MediaQuery.of(context).size.width * 0.28),
           
          ),
          Center(
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ClipOval(
                      child: Image(
                        image: AssetImage('assets/profile.png'),
                        width: MediaQuery.of(context).size.width * 0.28,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      'Peter Jackson',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    
                    Text(
                      'peter.jackson@gmail.com',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 15),
                    ),
                    SizedBox(height: 35),
                  ],
                ),
                Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrders()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                Icon(
                                  CupertinoIcons.bag_fill,
                                  color: MyColors.PrimaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('My Orders',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade800
                                  )
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ClaimYourWins()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                Icon(
                                  MdiIcons.cash,
                                  color: MyColors.PrimaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Cash Out',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade800
                                  )
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNav(index: 4,)));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.favorite,
                                  color: MyColors.PrimaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Favorites and Saves',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade800
                                  )
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                Icon(
                                  MdiIcons.ticket,
                                  color: MyColors.PrimaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Redeem Coupons',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade800
                                  )
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Rewards()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                Icon(
                                  MdiIcons.seal,
                                  color: MyColors.PrimaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Rewards',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade800
                                  )
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => WriteAReview()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                Icon(
                                  MdiIcons.starPlus,
                                  color: MyColors.PrimaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Write a Review',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade800
                                  )
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerSupport()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.headset_mic,
                                  color: MyColors.PrimaryColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Customer Support',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade800
                                  )
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.settings, color: MyColors.PrimaryColor, size: 20,),
                          SizedBox(width: 3,),
                          Text('Settings', 
                            style: TextStyle(
                              color: Colors.grey.shade800,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 6,),

                  Container(
                    height: 20,
                    child: VerticalDivider(color: Colors.black, width: 1,),
                  ),

                  SizedBox(width: 6,),

                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.logout, color: MyColors.PrimaryColor, size: 20,),
                          SizedBox(width: 3,),
                          Text('Logout', 
                            style: TextStyle(
                              color: Colors.grey.shade800,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}