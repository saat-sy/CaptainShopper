import 'package:flutter/material.dart';
import 'package:frontend/colors.dart';

class ClaimYourWins extends StatefulWidget {
  @override
  _ClaimYourWinsState createState() => _ClaimYourWinsState();
}

class _ClaimYourWinsState extends State<ClaimYourWins> {

  List<String> title = ['Giveaway won', 'Flashlight', 'Games'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Claim you Wins!',),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        height:MediaQuery.of(context).size.height,
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
                                child: Text('Claim and Deliver', style: TextStyle(color: Colors.white))
                              ),
                            ),
                          ],
                        ),
                      )

                    ]
                  ),
                ],
              )
            );
          },
        ),
      )
    );
  }
}