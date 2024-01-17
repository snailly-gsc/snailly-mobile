import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:snailly/app/data/models/notification_model.dart';
import 'package:snailly/app/routes/app_pages.dart';
import 'package:snailly/app/shared/shared.dart';
import 'package:snailly/app/widgets/widgets.dart';
import 'package:supercharged/supercharged.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StatusBar(
      brightness: Brightness.dark,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // * Header
              Container(
                padding: const EdgeInsets.only(
                  top: 40,
                  bottom: 18,
                  left: defaultPadding,
                ),
                decoration: BoxDecoration(
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: '000000'.toColor().withOpacity(.1),
                      offset: const Offset(0, 1),
                      blurRadius: 12,
                    )
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/ic_chevron_left.svg'),
                      const SizedBox(width: 10),
                      Text(
                        'Notifikasi',
                        style: boldNunitoFontStyle.copyWith(
                          color: lightGreenColor,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // * Notifications
              Obx(
                () => controller.isLoading.value == true
                    ? makeLoadingIndicator()
                    : Column(
                        children: [
                          for (var notification in controller.notifications)
                            NotificationCard(
                              notification,
                              onTap: () {
                                Get.toNamed(
                                  Routes.ACTION_PARENT,
                                  arguments: notification,
                                );
                              },
                            )
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
