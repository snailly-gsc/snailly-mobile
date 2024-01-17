import 'package:get/get.dart';

import '../controllers/preview_website_controller.dart';

class PreviewWebsiteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviewWebsiteController>(
      () => PreviewWebsiteController(),
    );
  }
}
