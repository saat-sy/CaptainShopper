import 'package:flutter/material.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/screens/authentication/login.dart';
import 'package:frontend/screens/authentication/verify_otp.dart';
import 'package:frontend/styles/style_sheet.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: MediaQuery.of(context).size.width * 0.65,
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 3.0, bottom: 5.0),
                      child: Text(
                        'Name',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10.0),
                          hintText: 'Peter Jhones',
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          suffixIcon: Visibility(
                            visible: true,
                            child: Icon(
                              Icons.person_outline_outlined,
                              size: 18,
                              color: MyColors.PrimaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                  color: Colors.grey.shade400, width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                  color: MyColors.PrimaryColor, width: 1.0))),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 3.0, bottom: 5.0),
                      child: Text(
                        'Phone no',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10.0),
                          hintText: '+1 123 456 7890',
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          suffixIcon: Visibility(
                            visible: true,
                            child: Icon(
                              Icons.phone_outlined,
                              size: 18,
                              color: MyColors.PrimaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                  color: Colors.grey.shade400, width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                  color: MyColors.PrimaryColor, width: 1.0))),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 3.0, bottom: 5.0),
                      child: Text(
                        'Email',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10.0),
                          hintText: 'username@emample.com',
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          suffixIcon: Visibility(
                            visible: true,
                            child: Icon(
                              Icons.email_outlined,
                              size: 18,
                              color: MyColors.PrimaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                  color: Colors.grey.shade400, width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                  color: MyColors.PrimaryColor, width: 1.0))),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 3.0, bottom: 5.0),
                      child: Text(
                        'Password',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextFormField(
                      cursorColor: MyColors.PrimaryColor,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 10.0),
                          hintText: 'Password',
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          suffixIcon: Visibility(
                            visible: true,
                            child: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 17,
                                color: MyColors.PrimaryColor,
                              ),
                              color: Colors.grey,
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                  color: Colors.grey.shade400, width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                  color: MyColors.PrimaryColor, width: 1.0))),
                    ),
                  ],
                ),
                SizedBox(height: 35),
                SubmitButton(
                  text: 'Register',
                  width: MediaQuery.of(context).size.width * 0.8,
                  onPress: () {
                    Navigator.push(context,
	                    MaterialPageRoute(builder: (context) => VerifyOTP()));
                  }
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 3.0),
                      ),
                      onPressed: () {
                        Navigator.push(context,
	                        MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        'Login here',
                        style: TextStyle(color: MyColors.PrimaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}