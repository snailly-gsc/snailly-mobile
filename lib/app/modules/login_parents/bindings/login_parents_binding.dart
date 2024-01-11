import 'package:get/get.dart';

import '../controllers/login_parents_controller.dart';

class LoginParentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginParentsController>(
      () => LoginParentsController(),
    );
  }
}
