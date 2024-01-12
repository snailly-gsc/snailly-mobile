import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:snailly/app/shared/shared.dart';
import 'package:snailly/app/widgets/widgets.dart';

import '../controllers/choose_child_controller.dart';

class ChooseChildView extends GetView<ChooseChildController> {
  const ChooseChildView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StatusBar(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // * Heading
              Stack(
                children: [
                  // * Background Circle
                  Image.asset(
                    "assets/images/bg_circle_small.png",
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? 350
                        : 275,
                    fit: BoxFit.fill,
                  ),
                  // * Title
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 8),
                        Text(
                          "Hi! What’s your name?",
                          textAlign: TextAlign.center,
                          style: headingPrimaryFontStyle,
                        ),
                        Text(
                          "Make sure you choose the right name",
                          textAlign: TextAlign.center,
                          style: headingSecondaryFontStyle,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 40),
              // * Child
              Obx(
                () => Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: controller.isLoading.value == true
                      ? makeLoadingIndicator()
                      : Column(
                          children: [
                            controller.childs.isEmpty
                                ? Text(
                                    "There is no child data.",
                                    style: headingSecondaryFontStyle.copyWith(
                                        color: blackColor),
                                  )
                                : const SizedBox(),
                            for (var child in controller.childs)
                              Container(
                                height: 60,
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      width: 1, color: lightGreenColor),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () =>
                                        controller.moveToBrowser(child),
                                    child: Center(
                                      child: Text(
                                        (child.name! as String).toUpperCase(),
                                        style: boldNunitoFontStyle.copyWith(
                                          fontSize: 16,
                                          color: lightGreenColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
