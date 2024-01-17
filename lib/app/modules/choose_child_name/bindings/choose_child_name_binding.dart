import 'package:get/get.dart';

import '../controllers/choose_child_name_controller.dart';

class ChooseChildNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseChildNameController>(
      () => ChooseChildNameController(),
    );
  }
}
