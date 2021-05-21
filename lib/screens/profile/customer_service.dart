import 'package:flutter/material.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/styles/style_sheet.dart';

class CustomerSupport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> ticket = [
      'Ticket 1561',
      'Ticket 1561',
      'Ticket 1561',
    ];

    List<bool> isComplaint = [true, false, false];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
                child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            icon: Icon(Icons.arrow_back),
                            color: Colors.black,
                            onPressed: () {}),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8),
                          child: Text('Welcome, \nPeter',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23)),
                        ),
                      ],
                    ),
                    Image(
                        image: AssetImage('assets/support.png'),
                        width: MediaQuery.of(context).size.width * 0.5)
                  ],
                ),
                Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                      decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    hintText: 'Search a ticket',
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
                Container(
                  padding: EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                      itemCount: ticket.length,
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8)),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(ticket[index],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17)),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: isComplaint[index]
                                            ? Colors.orangeAccent
                                            : Colors.purple,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                          isComplaint[index]
                                              ? 'Complaint'
                                              : 'General',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500)),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('March 16th, 2021 3:00 PM'),
                                    Text('+1 (42) 567-43214'),
                                  ],
                                )
                              ],
                            ));
                      }),
                )
              ],
            )),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SubmitButton(
                    text: 'Create New Ticket',
                    width: MediaQuery.of(context).size.width * 0.85,
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Problem with order? Email us at ',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        )
                      ),
                      Text('contact@captainshopper.com',
                        style: TextStyle(
                          fontSize: 13,
                          color: MyColors.PrimaryColor,
                          fontWeight: FontWeight.w600,
                        )
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
