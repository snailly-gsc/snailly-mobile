import 'package:snailly/app/utils/style.dart';
import 'package:flutter/material.dart';

import '../../../../utils/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.color,
    required this.press,
  }) : super(key: key);

  final String text;
  final VoidCallback press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(60),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: color,
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(40),
            color: kwhiteColor,
          ),
        ),
      ),
    );
  }
}
