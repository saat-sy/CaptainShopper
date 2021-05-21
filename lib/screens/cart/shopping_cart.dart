import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/styles/style_sheet.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<String> images = [
    'assets/products/giveaway/PS5.png',
    'assets/products/giveaway/iPhone2.png',
    'assets/products/giveaway/PS5.png',
    'assets/products/giveaway/iPhone2.png',
    'assets/products/giveaway/PS5.png',
    'assets/products/giveaway/iPhone2.png',
  ];

  List<String> title = [
    'PS5 Console',
    'iPhone 12',
    'PS5 Console',
    'iPhone 12',
    'PS5 Console',
    'iPhone 12',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Shopping Cart',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Items',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 5,),
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              child: ListView.builder(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 3.0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image(
                              width: MediaQuery.of(context).size.width * 0.2,
                              image: AssetImage(images[index]),
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title[index],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 3,),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '\$' + '199.99',
                                      style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 17,
                                          decoration: TextDecoration.lineThrough),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '\$' + '68.99',
                                      style: TextStyle(
                                        color: MyColors.PrimaryColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),                                    
                                  ],
                                ),
                                SizedBox(height: 3,),
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
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: MyColors.PrimaryColor
                              ),
                              child: Text(
                                '+',
                                style: TextStyle(
                                 fontSize: 17,
                                  color: Colors.  white,
                                  fontWeight: FontWeight.w600
                                )
                              ),
                            ),
                            SizedBox(height: 3,),
                            Text("1",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600
                              )
                            ),
                            SizedBox(height: 3,),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: MyColors.PrimaryColor
                              ),
                              child: Text(
                                '−',
                                style: TextStyle(
                                 fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600
                                )
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 10,),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(5),
                child: Column(
                  children: <Widget>[

                    SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Tax',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '\$160.99',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Shipping Charges',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '\$14.99',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),

                    Container(child: Divider(height: 1, color: Colors.grey,)),

                    SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Total',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        Text(
                          '\$175.98',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 10,),

                    SubmitButton(
                      text: 'Checkout',
                      onPress: () {},
                    ),

                    SizedBox(height: 20,)


                  ],
                ),
              ),
              )
          ],
        ),
      ),
    );
  }
}
