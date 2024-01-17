import 'package:get/get.dart';

import '../controllers/list_child_controller.dart';

class ListChildBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListChildController>(
      () => ListChildController(),
    );
  }
}
