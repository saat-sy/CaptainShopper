import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/models/deals_model.dart';
import 'package:frontend/models/giveaway_model.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<GiveawayModel> giveaway = [
    GiveawayModel(
        image: 'assets/products/giveaway/PS5.png',
        title: '\'Win\' PS 5 Console',
        members: '4,756',
        duration: '5 min',
        rating: '5.0'),
    GiveawayModel(
        image: 'assets/products/giveaway/iPhone2.png',
        title: '\'Win\' iPhone 6',
        members: '3,222',
        duration: '5 min',
        rating: '5.0'),
    GiveawayModel(
        image: 'assets/products/giveaway/PS5.png',
        title: '\'Win\' PS 5 Console',
        members: '5,345',
        duration: '5 min',
        rating: '5.0'),
    GiveawayModel(
        image: 'assets/products/giveaway/iPhone2.png',
        title: '\'Win\' iPhone 6',
        members: '4,125',
        duration: '5 min',
        rating: '5.0'),
    GiveawayModel(
        image: 'assets/products/giveaway/PS5.png',
        title: '\'Win\' PS 5 Console',
        members: '3,316',
        duration: '5 min',
        rating: '5.0'),
    GiveawayModel(
        image: 'assets/products/giveaway/iPhone2.png',
        title: '\'Win\' iPhone 6',
        members: '3,945',
        duration: '5 min',
        rating: '5.0'),
  ];

  List<DealsModel> deals = [
    DealsModel(
      title: 'Superfruit Berries',
      color: Color(0xFFD37C79),
      image: 'assets/products/product1.png'
    ),
    DealsModel(
      title: 'Happy Faces',
      color: Color(0xFF5C4D93),
      image: 'assets/products/product2.png'
    ),
    DealsModel(
      title: 'Superfruit Berries',
      color: Color(0xFFD37C79),
      image: 'assets/products/product1.png'
    ),
    DealsModel(
      title: 'Happy Faces',
      color: Color(0xFF5C4D93),
      image: 'assets/products/product2.png'
    ),
    DealsModel(
      title: 'Superfruit Berries',
      color: Color(0xFFD37C79),
      image: 'assets/products/product1.png'
    ),
    DealsModel(
      title: 'Happy Faces',
      color: Color(0xFF5C4D93),
      image: 'assets/products/product2.png'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
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
                      Container(
                        child: ListView.builder(
                          itemCount: giveaway.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade400, width: 0.5)
                              ),
                              padding: EdgeInsets.all(13),
                              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Row(
                                    children: [

                                      ClipOval(
                                        child: Image(
                                          image: AssetImage(giveaway[index].image),
                                          width: MediaQuery.of(context).size.width * 0.2,
                                        ),
                                      ),

                                      SizedBox(width: 15,),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text(giveaway[index].title,
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          SizedBox(height: 5,),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                children: [
                                                  Icon(CupertinoIcons.clock, color: MyColors.PrimaryColor, size: 16,),
                                                  SizedBox(height: 2,),
                                                  Text('5 min',
                                                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 14)
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 10,),
                                              Column(
                                                children: [
                                                  Icon(CupertinoIcons.person, color: MyColors.PrimaryColor,size: 16,),
                                                  SizedBox(height: 4,),
                                                  Text('4800/5000*',
                                                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 14)
                                                  ),
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
                                    child: Icon(CupertinoIcons.heart_fill, color: MyColors.PrimaryColor, size: 30,),
                                  )

                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        child: ListView.builder(
                          itemCount: giveaway.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey.shade400, width: 0.5)
                              ),
                              padding: EdgeInsets.all(13),
                              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              child: Row(
                                children: [

                                  Image(
                                    image: AssetImage(deals[index].image),
                                    width: MediaQuery.of(context).size.width * 0.2,
                                  ),

                                  SizedBox(width: 10,),

                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '5 Packs of ${deals[index].title}',
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
                                              '\$' + '199.99',
                                              style: TextStyle(
                                                  color: Colors.grey.shade400,
                                                  fontSize: 16,
                                                  decoration: TextDecoration.lineThrough),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '\$' + '68.99',
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
                                                  borderRadius: BorderRadius.circular(8),
                                                  color: Colors.green.withOpacity(0.15)),
                                              child: Center(
                                                child: Text(
                                                  '75' + '% OFF',
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
                                              '5.0',
                                              style: TextStyle(color: Colors.grey),
                                            ),
                                            SizedBox(
                                              width: 5,
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
                                              'Candy Cane',
                                              style: TextStyle(color: MyColors.PrimaryColor),
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
                      Container(
                        child: Center(
                          child: Text('Add new folder',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ]))
              ])),
    );
  }
}
