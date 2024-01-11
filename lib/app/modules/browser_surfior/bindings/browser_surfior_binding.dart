import 'package:get/get.dart';

import '../controllers/browser_surfior_controller.dart';

class BrowserSurfiorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BrowserSurfiorController>(
      () => BrowserSurfiorController(),
    );
  }
}
