import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/models/deals_model.dart';
import 'package:frontend/screens/productScreens/dealsProduct.dart';

class Deals extends StatefulWidget {
  @override
  _DealsState createState() => _DealsState();
}

class _DealsState extends State<Deals> {

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
      child: Container(
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DealsProductScreen()));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: new BoxDecoration(
                        color: deals[index].color,
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                width: MediaQuery.of(context).size.width * 0.3,
                                image: AssetImage(deals[index].image),
                              ),
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
                                    '5 Packs of ${deals[index].title}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
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
                                            fontSize: 21,
                                            decoration: TextDecoration.lineThrough),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '\$' + '68.99',
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
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
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '(6,256 Ratings)',
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
                                                'Candy Cane',
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