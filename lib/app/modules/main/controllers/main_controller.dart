import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  late PageController pageController;
  var selectedPage = 0.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    pageController = PageController(initialPage: selectedPage.value);
    super.onInit();
  }
}
