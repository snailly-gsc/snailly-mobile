import 'package:snailly/app/utils/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../utils/style.dart';

// ignore: must_be_immutable
class InputTextField extends StatelessWidget {
  InputTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.textInputType,
  }) : super(key: key);

  TextEditingController controller;
  TextInputType? textInputType;
  String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
          color: kwhiteColor, fontSize: getProportionateScreenWidth(32)),
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        fillColor: bgButtonColor,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: bgButtonColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: bgButtonColor),
        ),
        hintText: hintText,
        hintStyle: kTextStyleColor,
      ),
    );
  }
}
