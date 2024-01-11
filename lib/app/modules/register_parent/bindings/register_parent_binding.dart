import 'package:get/get.dart';

import '../controllers/register_parent_controller.dart';

class RegisterParentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterParentController>(
      () => RegisterParentController(),
    );
  }
}
