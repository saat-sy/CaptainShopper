import 'package:flutter/material.dart';
import '../colors.dart';

class SubmitButton extends StatelessWidget {
  final Function onPress;
  final String text;
  final double width;

  SubmitButton({this.onPress, this.text, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 45,
      child: TextButton(
        onPressed: onPress,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(MyColors.PrimaryColor),
        ),
      ),
    );
  }
}
