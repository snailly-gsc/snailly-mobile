import 'package:get/get.dart';

import '../controllers/report_monthly_controller.dart';

class ReportMonthlyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportMonthlyController>(
      () => ReportMonthlyController(),
    );
  }
}
