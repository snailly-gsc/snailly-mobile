import 'package:get/get.dart';

import '../controllers/report_all_controller.dart';

class ReportAllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportAllController>(
      () => ReportAllController(),
    );
  }
}
