import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snailly/app/data/models/log_activity_model.dart';
import 'package:snailly/app/extensions/extensions.dart';
import 'package:snailly/app/modules/home/controllers/home_controller.dart';
import 'package:snailly/app/shared/shared.dart';

import 'package:snailly/app/widgets/widgets.dart';

class ReportDailyView extends StatelessWidget {
  final controller = Get.put(HomeController());
  ReportDailyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          InputDate.daily(
            controller.selectedDate.value,
            onTap: (date) {
              controller.selectedDate.value = date;
              controller.clearLogs();
              controller.getDaily();
            },
          ),
          const SizedBox(height: 20),
          for (var log in controller.logs)
            ActivityCard(
              title: (log as LogActivityModel).webTitle!,
              description: log.createdAt!.dateYearTime,
              // isNegative: log.grantAccess == true
              //     ? false
              //     : log.finalLabel == 'aman'
              //         ? false
              //         : true,
              statusLog: log.statusLog,
              isGrantAccess: log.grantAccess == true ? true : false,
              onUpdateGrantAccess: (isAllow) {
                controller.openDialogGrantAccess(log.id!, isAllow, 'all');
              },
            ),
          controller.page.value == controller.totalPage.value
              ? const SizedBox()
              : controller.logs.isEmpty
                  ? Text(
                      'Data tidak ada.',
                      style: mediumNunitoFontStyle.copyWith(color: grayColor),
                    )
                  : makeLoadingIndicator(),
          const SizedBox(height: 75),
        ],
      ),
    );
  }
}
