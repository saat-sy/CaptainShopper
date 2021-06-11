import 'package:flutter/material.dart';
import 'package:frontend/screens/authentication/register_mobile/register_mobile.dart';
import 'package:frontend/screens/authentication/register_web/register_web.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 768)
          return RegisterWeb();
        else 
          return RegisterMobile();
      },
    );
  }
}
