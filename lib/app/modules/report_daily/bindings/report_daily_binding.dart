import 'package:get/get.dart';

import '../controllers/report_daily_controller.dart';

class ReportDailyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportDailyController>(
      () => ReportDailyController(),
    );
  }
}
