import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:snailly/app/routes/app_pages.dart';
import 'package:snailly/app/shared/shared.dart';
import 'package:snailly/app/widgets/widgets.dart';

import '../controllers/action_parent_controller.dart';

class ActionParentView extends GetView<ActionParentController> {
  const ActionParentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StatusBar(
      child: Scaffold(
        backgroundColor: greenColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // * Heading
                  Stack(
                    children: [
                      // * Background Circle
                      Image.asset(
                        "assets/images/bg_circle.png",
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? 350
                            : MediaQuery.of(context).size.height / 2,
                        fit: BoxFit.fill,
                      ),
                      // * Action
                      Center(
                        child: Column(
                          children: [
                            // * Title
                            SizedBox(
                                height: MediaQuery.of(context).size.height / 7),
                            SvgPicture.asset(
                              "assets/icons/ic_tindakan.svg",
                              width: 100,
                              height: 100,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Lakukan Tindakan!",
                              textAlign: TextAlign.center,
                              style: headingPrimaryFontStyle,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.15,
                              child: Text(
                                controller.notification != null
                                    ? controller.notification!.text
                                    : controller.notificationMap!['text'],
                                textAlign: TextAlign.center,
                                style: headingSecondaryFontStyle,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  // * Button Action
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        Button(
                          text: "Blokir Akses",
                          buttonStyle: makeButton(redColor),
                          onTap: () {
                            controller.updateGrantAccess('False');
                          },
                        ),
                        const SizedBox(height: 16),
                        Button(
                          text: "Izinkan Akses",
                          onTap: () {
                            controller.updateGrantAccess('True');
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 6.6),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              Routes.PREVIEW_WEBSITE,
                              arguments: controller.getPreviewUrl(),
                            );
                          },
                          child: Text(
                            'Pratinjau website yang dikunjungi',
                            style: semiBoldNunitoFontStyle.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => controller.isLoading.value == true
                  ? const Loading()
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
