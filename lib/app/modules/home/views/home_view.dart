import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:snailly/app/extensions/extensions.dart';
import 'package:snailly/app/modules/home/controllers/home_controller.dart';
import 'package:snailly/app/modules/report_all/views/report_all_view.dart';
import 'package:snailly/app/modules/report_daily/views/report_daily_view.dart';
import 'package:snailly/app/modules/report_monthly/views/report_monthly_view.dart';
import 'package:snailly/app/routes/app_pages.dart';
import 'package:snailly/app/shared/shared.dart';
import 'package:snailly/app/widgets/widgets.dart';
import 'package:supercharged/supercharged.dart';

class HomeView extends StatelessWidget {
  final controller = Get.put(HomeController());
  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller.scrollController,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.5,
            color: darkGreenColor,
          ),
          Column(
            children: [
              // * Heading
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    // * Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi, Orang Tua",
                              style: extraBoldNunitoFontStyle.copyWith(
                                  fontSize: 18),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateTime.now().dateYear,
                              style: mediumNunitoFontStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Material(
                            color: whiteColor.withOpacity(.12),
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                Get.toNamed(Routes.NOTIFICATION);
                              },
                              child: Center(
                                child: SvgPicture.asset(
                                    'assets/icons/ic_notification.svg'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    // * Child Select
                    Text('Nama anak ditinjau', style: boldNunitoFontStyle),
                    const SizedBox(height: 8),
                    Obx(
                      () => InputSelect(
                        controller.child.value.name!,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const ModalChild(),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 25),
                    // * Card Summary
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [defaultBoxShadow],
                      ),
                      child: Obx(
                        () => controller.isLoadingSummary.value == true
                            ? Padding(
                                padding: const EdgeInsets.all(16),
                                child: makeLoadingIndicator(),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Konten Ringkasan Bulanan Diakses',
                                    style: semiBoldNunitoFontStyle.copyWith(
                                      fontSize: 16,
                                      color: grayColor,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 100,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: 'E1E3E5'.toColor(),
                                              width: 1),
                                        ),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                'Persentase',
                                                style: semiBoldNunitoFontStyle
                                                    .copyWith(
                                                  color: grayColor,
                                                ),
                                              ),
                                              const SizedBox(height: 3),
                                              Text(
                                                controller.summary.value
                                                            .persentageSafeWebsite! >=
                                                        controller.summary.value
                                                            .persentageDangerousWebsite!
                                                    ? '${controller.summary.value.persentageSafeWebsite}%'
                                                    : '${controller.summary.value.persentageDangerousWebsite}%',
                                                style: extraBoldNunitoFontStyle
                                                    .copyWith(
                                                  color: lightGreenColor,
                                                  fontSize: 18,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: 'E1E3E5'.toColor(),
                                              width: 1),
                                        ),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                'Positif',
                                                style: semiBoldNunitoFontStyle
                                                    .copyWith(
                                                  color: grayColor,
                                                ),
                                              ),
                                              const SizedBox(height: 3),
                                              Text(
                                                '${controller.summary.value.totalSafeWebsite}',
                                                style: extraBoldNunitoFontStyle
                                                    .copyWith(
                                                  color: blueColor,
                                                  fontSize: 18,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: 'E1E3E5'.toColor(),
                                              width: 1),
                                        ),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Text(
                                                'Negatif',
                                                style: semiBoldNunitoFontStyle
                                                    .copyWith(
                                                  color: grayColor,
                                                ),
                                              ),
                                              const SizedBox(height: 3),
                                              Text(
                                                '${controller.summary.value.totalDangerousWebsite}',
                                                style: extraBoldNunitoFontStyle
                                                    .copyWith(
                                                  color: redColor,
                                                  fontSize: 18,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    controller.summary.value
                                                .persentageSafeWebsite! >=
                                            controller.summary.value
                                                .persentageDangerousWebsite!
                                        ? 'Anak Anda mengakses ${controller.summary.value.persentageSafeWebsite}% konten positif'
                                        : 'Anak Anda mengakses ${controller.summary.value.persentageDangerousWebsite}% konten negatif',
                                    style: semiBoldNunitoFontStyle.copyWith(
                                      color: lightGreenColor,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              // * Tabbar
              Obx(
                () => CustomTabBar(
                  titles: const ['Semua', 'Harian', 'Bulanan'],
                  selectedIndex: controller.selectedIndex.value,
                  onTap: (index) {
                    controller.selectedIndex.value = index;
                    controller.clearLogs();
                    switch (controller.selectedIndex.value) {
                      case 0:
                        controller.getAll();
                        break;
                      case 1:
                        controller.getDaily();
                        break;
                      case 2:
                        controller.getMonthly();
                        break;
                    }
                  },
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: controller.selectedIndex.value == 0
                      ? ReportAllView()
                      : controller.selectedIndex.value == 1
                          ? ReportDailyView()
                          : ReportMonthlyView(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
