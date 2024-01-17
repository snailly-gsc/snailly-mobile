import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:snailly/app/modules/child/controllers/child_controller.dart';
import 'package:snailly/app/modules/child/views/child_view.dart';
import 'package:snailly/app/modules/home/views/home_view.dart';
import 'package:snailly/app/modules/profile/views/profile_view.dart';
import 'package:snailly/app/shared/shared.dart';
import 'package:snailly/app/widgets/widgets.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final childController = Get.put(ChildController());
    return StatusBar(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Stack(
          children: [
            // * Page View
            PageView(
              controller: controller.pageController,
              onPageChanged: (index) {
                controller.selectedPage.value = index;
                if (index == 1) {
                  childController.getChilds();
                }
              },
              children: [
                // * Home Page
                HomeView(),
                // * Child Page
                ChildView(),
                // * Profile Page
                ProfileView(),
              ],
            ),
            // * Bottom Navigation
            Obx(
              () => CustomBottomNavigation(
                selectedIndex: controller.selectedPage.value,
                onTap: (index) {
                  controller.selectedPage.value = index;
                  controller.pageController.animateToPage(
                    controller.selectedPage.value,
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 400),
                  );
                },
              ),
            ),
            // * Loading
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
