import 'package:flutter/material.dart';
import 'package:frontend/colors.dart';
import 'package:frontend/screens/authentication/register.dart';
import 'package:frontend/screens/bottomNav/bottomNav.dart';
import 'package:frontend/services/authentication_service.dart';
import 'package:frontend/styles/style_sheet.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
  final passwordController = TextEditingController();

  String error = '';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
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
                  SizedBox(height: 17),
                  Text(
                    error,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 17),
                  Column(
                    children: <Widget>[
                      SubmitButton(
                          text: 'Login',
                          width: MediaQuery.of(context).size.width * 0.8,
                          onPress: () async {
                            if (_formKey.currentState.validate()) {
                              showLoaderDialog(context);
                              final result = await context
                                  .read<AuthenticationService>()
                                  .signIn(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim());
                              if (result != 'Signed in successfully')
                                setState(() {
                                  error = result;
                                });
                              else {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BottomNav()));
                              }
                            }
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Forgot Password?'),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 3.0),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Recover here',
                              style: TextStyle(color: MyColors.PrimaryColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 3.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text(
                        'Signup here',
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
