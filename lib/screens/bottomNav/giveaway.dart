import 'package:flutter/material.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/models/giveaway_model.dart';
import 'package:frontend/screens/productScreens/giveawayProductScreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Giveaway extends StatefulWidget {
  @override
  _GiveawayState createState() => _GiveawayState();
}

class _GiveawayState extends State<Giveaway> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
          length: 2,
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
                          color: MyColors.PrimaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15)),
                      tabs: [
                        Container(
                          height: 25.0,
                          child: Tab(
                            child: Text('Big Prizes'),
                          ),
                        ),
                        Container(
                          height: 25.0,
                          child: Tab(
                            child: Text('Small Prizes'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: TabBarView(children: <Widget>[
                      Content(),
                      Content(),
                    ]
                    )
                ),
              ]
          )
      )
    );
              
  }
}







class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {

  List<GiveawayModel> giveaway = [
    GiveawayModel(
      image: 'assets/products/giveaway/PS5.jpg',
      title: '\'Win\' PS 5 Console',
      members: '4,756',
      duration: '5 min',
      rating: '5.0'
    ),
    GiveawayModel(
      image: 'assets/products/giveaway/iPhone.png',
      title: '\'Win\' iPhone 6',
      members: '3,222',
      duration: '5 min',
      rating: '5.0'
    ),
    GiveawayModel(
      image: 'assets/products/giveaway/PS5.jpg',
      title: '\'Win\' PS 5 Console',
      members: '5,345',
      duration: '5 min',
      rating: '5.0'
    ),
    GiveawayModel(
      image: 'assets/products/giveaway/iPhone.png',
      title: '\'Win\' iPhone 6',
      members: '4,125',
      duration: '5 min',
      rating: '5.0'
    ),
    GiveawayModel(
      image: 'assets/products/giveaway/PS5.jpg',
      title: '\'Win\' PS 5 Console',
      members: '3,316',
      duration: '5 min',
      rating: '5.0'
    ),
    GiveawayModel(
      image: 'assets/products/giveaway/iPhone.png',
      title: '\'Win\' iPhone 6',
      members: '3,945',
      duration: '5 min',
      rating: '5.0'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: ListView.builder(
        itemCount: giveaway.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => GiveawayProduct()));
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 7),
              child: Container(
                  child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image(
                      image: AssetImage(giveaway[index].image),
                      width: MediaQuery.of(context).size.width,
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
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Icon(Icons.person, color: Colors.white, size: 17),
                                Text(
                                  giveaway[index].members,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
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
                                      color: Colors.white, fontSize: 13),
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
                            Icon(Icons.star, color: Colors.amber, size: 17),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              giveaway[index].rating,
                              style: TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: MyColors.PrimaryColor,
                                  border:
                                      Border.all(color: MyColors.PrimaryColor)),
                              child: Center(
                                child: Text(
                                  'Watch Now',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white.withOpacity(0),
                                  border: Border.all(color: Colors.white)),
                              child: Center(
                                child: Text(
                                  'View Details',
                                  style: TextStyle(color: Colors.white),
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
    );
  }
}