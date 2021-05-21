import 'package:flutter/material.dart';
import 'package:frontend/styles/style_sheet.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text('Credit Card Info',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Container(
              child: Divider(color: Colors.black, height: 2),
            ),

            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Name on your Credit Card',
                labelText: 'Name',
              ),
            ),

            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Credit Card Number',
                labelText: 'Number',
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'CCV',
                    ),
                  ),
                ),

                Row(
                  children: [

                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Month',
                          labelText: 'Expiration',
                        ),
                      ),
                    ),

                    SizedBox(width: 10,),

                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: '',
                          hintText: 'Year',
                        ),
                      ),
                    ),

                  ],
                )

              ]
            ),

            SizedBox(height: 20),

            Text('Account Info',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Container(
              child: Divider(color: Colors.black, height: 2),
            ),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),

            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Phone No',
              ),
            ),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Address',
              ),
            ),

            SizedBox(height: 20),

            SubmitButton(
              text: 'Save Changes'
            )

          ],
        ),
      ),
    );
  }
}