import 'package:get/get.dart';

import '../controllers/allow_parent_controller.dart';

class AllowParentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllowParentController>(
      () => AllowParentController(),
    );
  }
}
