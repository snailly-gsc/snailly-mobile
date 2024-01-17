import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:snailly/app/shared/shared.dart';
import 'package:snailly/app/widgets/widgets.dart';

import '../controllers/block_parent_controller.dart';

class BlockParentView extends GetView<BlockParentController> {
  const BlockParentView({Key? key}) : super(key: key);
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
                "assets/icons/ic_blokir.svg",
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 16),
              Text(
                "Akses Diblokir!",
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
