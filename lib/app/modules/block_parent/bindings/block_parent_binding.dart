import 'package:get/get.dart';

import '../controllers/block_parent_controller.dart';

class BlockParentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlockParentController>(
      () => BlockParentController(),
    );
  }
}
