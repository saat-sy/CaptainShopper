import 'package:flutter/material.dart';
import 'package:frontend/screens/bottomNav/bottomNav.dart';
import 'package:frontend/styles/style_sheet.dart';
import 'package:pinput/pin_put/pin_put.dart';

import '../../colors.dart';

class VerifyOTP extends StatefulWidget {
  @override
  _VerifyOTPState createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {

  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: MyColors.PrimaryColor,
        width: 1,
      ),
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Image(
            image: AssetImage('assets/images/otp.png'),
            height: MediaQuery.of(context).size.height * 0.2,
          ),

          SizedBox(height: 30,),

          Text(
            'Verify OTP',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),

          SizedBox(
            height: 5,
          ),

          Text(
            'You will get an OTP via SMS',
            style: TextStyle(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
                fontSize: 15),
          ),

          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.all(30.0),
            child: PinPut(
              fieldsCount: 6,
              withCursor: true,
              textStyle: const TextStyle(fontSize: 25.0, color: MyColors.PrimaryColor),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              onSubmit: (String pin) => {},
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
            ),
          ),

          SizedBox(height: 20,),

          SubmitButton(
            text: 'Verify Phone no',
            width: MediaQuery.of(context).size.width * 0.8,
            onPress: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNav()));
            }
          )

        ],
      ),
    );
  }
}