import 'package:get/get.dart';

import '../controllers/login_move_to_reportior_controller.dart';

class LoginMoveToReportiorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginMoveToReportiorController>(
      () => LoginMoveToReportiorController(),
    );
  }
}
