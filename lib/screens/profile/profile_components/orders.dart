import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  List<String> images = [
    'assets/products/giveaway/PS5.png',
    'assets/products/giveaway/iPhone2.png',
    'assets/products/giveaway/PS5.png',
    'assets/products/giveaway/iPhone2.png',
    'assets/products/giveaway/PS5.png',
  ];

  List<String> title = [
    'Order#: 95354',
    'Order#: 75424',
    'Order#: 47825',
    'Order#: 32169',
    'Order#: 26416'
  ];

  List<bool> isDelivered = [false, true, true, true, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 15),
              child: Text(
                'My Orders',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  )
                                ),
                                SizedBox(height: 3),
                                Text('05-May-2021, 3:00PM',
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                  )
                                ),
                              ],
                            ),
                            Image(
                              image: AssetImage(images[index]),
                              width: MediaQuery.of(context).size.width * 0.2
                            )
                          ]
                        ),

                        SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isDelivered[index] ? "Delivered" : "Estimated delivery on May 10",
                              style: TextStyle(
                                color: isDelivered[index] ? Colors.redAccent : Colors.green
                              ),
                            ),

                            Row(
                              children: [
                                Text(isDelivered[index] ? "You Rated" : "Rating"),
                                RatingBarIndicator(
                                  rating: isDelivered[index] ? 5 : 0,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 13.0,
                                ),
                              ]
                            )
                          ]
                        )

                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
