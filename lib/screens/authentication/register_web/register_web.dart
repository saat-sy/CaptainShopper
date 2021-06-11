import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/screens/authentication/login.dart';
import 'package:frontend/screens/bottomNav/bottomNav.dart';
import 'package:frontend/services/authentication_service.dart';
import 'package:frontend/styles/style_sheet.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum RegisterWebOTPState { SHOW_REGISTER, SHOW_OTP }

class RegisterWeb extends StatefulWidget {
  @override
  _RegisterWebState createState() => _RegisterWebState();
}

class _RegisterWebState extends State<RegisterWeb> {
  RegisterWebOTPState currentState = RegisterWebOTPState.SHOW_REGISTER;

  bool _obscureText = true;

  String verifyEmail(String val) {
    if (val.isEmpty)
      return 'Enter your Email';
    else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(val))
      return 'Enter a valid Email Address';
    else
      return null;
  }

  String verifyPhoneNo(String val) {
    if (val.isEmpty)
      return 'Enter your Phone number';
    // else if (val.length != 10)
    //   return 'Enter a valid Phone number';
    else
      return null;
  }

  String verifyPassword(String val) {
    if (val.isEmpty)
      return 'Enter a Password';
    else if (val.length < 8)
      return 'Password must be atleast 8 characters long';
    else
      return null;
  }

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();

  String error = '';

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  String verificationId;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return currentState == RegisterWebOTPState.SHOW_REGISTER
        ? getRegisterWebScreen(context)
        : getOTPScreen(context);
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 55, width: 55, child: CircularProgressIndicator()),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  getRegisterWebScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width > 1400 ? MediaQuery.of(context).size.width * 0.25 : MediaQuery.of(context).size.width * 0.38,
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  Image.asset(
                    'assets/images/logo.png',
                    width: MediaQuery.of(context).size.width * 0.15,
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
                        controller: nameController,
                        validator: (val) =>
                            val.isEmpty ? 'Enter your name' : null,
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
                                  color: MyColors.PrimaryColor, width: 1.0)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0)),
                        ),
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
                        controller: phoneController,
                        validator: (val) => verifyPhoneNo(val),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
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
                                  color: MyColors.PrimaryColor, width: 1.0)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0)),
                        ),
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
                        controller: emailController,
                        validator: (val) => verifyEmail(val),
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
                                  color: MyColors.PrimaryColor, width: 1.0)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0)),
                        ),
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
                        controller: passwordController,
                        validator: (val) => verifyPassword(val),
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
                                  color: MyColors.PrimaryColor, width: 1.0)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.0)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.5),
                  Text(
                    error,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 8.5),
                  SubmitButton(
                      text: 'Sign Up',
                      width: MediaQuery.of(context).size.width * 0.8,
                      onPress: () async {
                        if (_formKey.currentState.validate()) {
                          showLoaderDialog(context);
                          final result = await context
                              .read<AuthenticationService>()
                              .signUp(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim());
                          if (result != 'Registered successfully') {
                            setState(() {
                              error = result;
                            });
                            Navigator.pop(context);
                          } else
                            await _auth.verifyPhoneNumber(
                                phoneNumber:
                                    phoneController.text.startsWith('+')
                                        ? phoneController.text
                                        : '+1' + phoneController.text,
                                verificationCompleted:
                                    (phoneAuthCredential) async {},
                                verificationFailed: (verificationFailed) async {
                                  _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              verificationFailed.message)));
                                },
                                codeSent: (verID, resend) {
                                  Navigator.pop(context);
                                  setState(() {
                                    verificationId = verID;
                                    currentState = RegisterWebOTPState.SHOW_OTP;
                                  });
                                },
                                codeAutoRetrievalTimeout: (verID) {});
                        }
                      }),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account? '),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 3.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Text(
                            'Login here',
                            style: TextStyle(color: MyColors.PrimaryColor),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getOTPScreen(BuildContext context) {
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
          SizedBox(
            height: 30,
          ),
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
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: PinPut(
              fieldsCount: 6,
              withCursor: true,
              textStyle:
                  const TextStyle(fontSize: 25.0, color: MyColors.PrimaryColor),
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
          SizedBox(
            height: 20,
          ),
          SubmitButton(
              text: 'Verify Phone no',
              width: MediaQuery.of(context).size.width * 0.8,
              onPress: () {
                signUp(context);
              })
        ],
      ),
    );
  }

  Future<void> signUp(BuildContext context) async {
    showLoaderDialog(context);

    PhoneAuthCredential _phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: _pinPutController.text);

    User user = _auth.currentUser;
    await user.updateProfile(displayName: nameController.text);
    await user.linkWithCredential(_phoneAuthCredential);

    await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
      'giveaway_favorite': "",
      'coupon_favorite': "",
      'deals_favorite': "",
      'cart': "",
      'orders': "",
      'currentPoints': 0,
      'lifetimePoints': 0,
      'points_history': "",
      'coupon_history': "",
      'coupons': ""
    });

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('Credit Card Details')
        .doc('CreditCardInfo')
        .set({
      'credit_card_name': '',
      'credit_card_no': '',
      'credit_card_expiration': ''
    });

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('Address')
        .doc('AddressList')
        .set({
      'name': '',
      'address': '',
    });

    Navigator.pop(context);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BottomNav()));
  }
}
