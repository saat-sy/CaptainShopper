import 'package:flutter/material.dart';
import 'package:frontend/colors.dart';

class WriteAReview extends StatefulWidget {
  @override
  _WriteAReviewState createState() => _WriteAReviewState();
}

class _WriteAReviewState extends State<WriteAReview> {

  List<String> title = [
    'Giveaway won',
    'Flashlight',
    'Games'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Earn Points'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [

            Container(
              padding: EdgeInsets.all(5),
              color: MyColors.PrimaryColor.withOpacity(0.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Icon(
                    Icons.info_outline,
                    color: MyColors.PrimaryColor,
                    size: 20
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Write a review to earn points!',
                    style: TextStyle(
                      color: MyColors.PrimaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15
                    )
                  )

                ],
              )
            ),

            Container(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [

                  Text('CURRENT POINTS'),

                  SizedBox(height: 10,),

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: MyColors.PrimaryColor
                    ),
                    child: Text(
                      '3,110',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.white
                      )
                    )
                  ),

                  SizedBox(height: 10,),

                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: MyColors.PrimaryColor.withOpacity(0.15)
                    ),
                    child: Text(
                      'Lifetime Score: 22,100',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: MyColors.PrimaryColor
                      )
                    )
                  )

                ],
              )
            ),

            Container(
              height:MediaQuery.of(context).size.height * 0.55,
              child: ListView.builder(
                itemCount: title.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300, width: 1.0),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          children: [

                            Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Colors.grey.shade300, width: 1.0),
                                ),
                              ),
                              child: Text('\$10',
                                style: TextStyle(
                                  color: MyColors.PrimaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                                )
                              )
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title[index],
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                                  ),

                                  SizedBox(height: 3),

                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: MyColors.PrimaryColor
                                    ),
                                    child: Center(
                                      child: Text('Write a Review', style: TextStyle(color: Colors.white))
                                    ),
                                  ),
                                ],
                              ),
                            )

                          ]
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: MyColors.PrimaryColor
                              ),
                              child: Center(
                                child: Text('10 pts', style: TextStyle(color: Colors.white))
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  );
                },
              ),
            )

          ],
        ),
      )
    );
  }
}