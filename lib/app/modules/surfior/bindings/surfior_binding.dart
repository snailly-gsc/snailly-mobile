import 'package:get/get.dart';

import '../controllers/surfior_controller.dart';

class SurfiorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurfiorController>(
      () => SurfiorController(),
    );
  }
}
