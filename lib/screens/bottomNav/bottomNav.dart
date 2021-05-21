import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/screens/bottomNav/coupons.dart';
import 'package:frontend/screens/bottomNav/deals.dart';
import 'package:frontend/screens/bottomNav/fav.dart';
import 'package:frontend/screens/bottomNav/giveaway.dart';
import 'package:frontend/screens/bottomNav/home.dart';
import 'package:frontend/screens/cart/shopping_cart.dart';
import 'package:frontend/screens/profile/profile.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BottomNav extends StatefulWidget {
  final int index;
  BottomNav({this.index});
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  bool indexUsed = false;
  int _currentIndex = 2;

  final screens = [Giveaway(), Coupons(), Home(), Deals(), Favorite()];

  @override
  Widget build(BuildContext context) {
    if (!indexUsed) {
      _currentIndex = widget.index ?? 2;
      indexUsed = true;
    }
    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profile()));
                    },
                    child: Container(
                        padding: EdgeInsets.only(top: 5),
                        child: Icon(MdiIcons.accountCircle, size: 30)),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 35),
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                      width: MediaQuery.of(context).size.width * 0.45,
                    ),
                  ),
                  Container(
                    child: Row(children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            padding: EdgeInsets.only(right: 5, top: 6),
                            child: Icon(Icons.notifications,
                                color: Colors.grey, size: 27)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShoppingCart()));
                        },
                        child: Container(
                            padding: EdgeInsets.only(left: 5, top: 6),
                            child: Icon(Icons.shopping_cart,
                                color: Colors.grey, size: 27)),
                      ),
                    ]),
                  ),
                ]),
          ),
          Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
                decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
              hintText: 'Search a product',
              fillColor: Colors.white,
              filled: true,
              prefixIcon: Visibility(
                visible: true,
                child: Icon(
                  Icons.search,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide:
                      BorderSide(color: Colors.grey.shade500, width: 1)),
            )),
          ),
          screens[_currentIndex]
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.gift),
              label: 'Giveaway',
              backgroundColor: MyColors.PrimaryColor,
            ),
            BottomNavigationBarItem(
                icon: Icon(MdiIcons.ticket), label: 'Coupons'),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: MyColors.PrimaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.tag),
              label: 'Deals',
              backgroundColor: MyColors.PrimaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
              backgroundColor: MyColors.PrimaryColor,
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }
}
