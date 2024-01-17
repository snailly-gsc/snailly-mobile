import 'package:get/get.dart';

import '../controllers/child_controller.dart';

class ChildBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChildController>(
      () => ChildController(),
    );
  }
}
