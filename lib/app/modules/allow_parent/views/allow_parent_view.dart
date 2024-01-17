import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:snailly/app/shared/shared.dart';
import 'package:snailly/app/widgets/widgets.dart';

import '../controllers/allow_parent_controller.dart';

class AllowParentView extends GetView<AllowParentController> {
  const AllowParentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StatusBar(
      child: Scaffold(
        backgroundColor: greenColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // * Title
              SvgPicture.asset(
                "assets/icons/ic_izinkan.svg",
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 16),
              Text(
                "Akses Diizinkan!",
                textAlign: TextAlign.center,
                style: headingPrimaryFontStyle,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.15,
                child: Text(
                  "Menjaga anak-anak Anda memiliki keselamatan menjelajah",
                  textAlign: TextAlign.center,
                  style: headingSecondaryFontStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
