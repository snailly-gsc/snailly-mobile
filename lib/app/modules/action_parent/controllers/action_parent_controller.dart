 import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:snailly/app/data/models/notification_model.dart';
import 'package:snailly/app/routes/app_pages.dart';
import 'package:snailly/app/shared/shared.dart';
import 'package:snailly/app/utils/constanta.dart';

class ActionParentController extends GetxController {
  final _endPoint = "log/grant-access/";
  RxBool isLoading = false.obs;
  NotificationModel? notification;
  Map<String, dynamic>? notificationMap;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is NotificationModel) {
      notification = Get.arguments;
    } else {
      notificationMap = Get.arguments;
    }
  }

  Future<void> updateGrantAccess(String isAllow) async {
    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;
    String accessToken = data["token"];

    try {
      String logId;

      if (notification != null) {
        logId = notification!.logId!;
      } else {
        logId = notificationMap!['logId'];
      }

      isLoading.value = true;
      var response = await http.put(
        Uri.parse(
          baseUrl + _endPoint + logId,
        ),
        headers: {'Authorization': 'Bearer $accessToken'},
        body: {
          "grantAccess": isAllow,
        },
      );

      if (response.statusCode != 200) {
        throw (json.decode(response.body)["message"]);
      }

      isLoading.value = false;

      if (isAllow == 'True') {
        Get.offAndToNamed(Routes.ALLOW_PARENT);
      } else {
        Get.offAndToNamed(Routes.BLOCK_PARENT);
      }
    } catch (err) {
      isLoading.value = false;
      showSnackBar(err.toString());
    }
  }

  String getPreviewUrl() {
    String text =
        notification != null ? notification!.text : notificationMap!['text'];

    var textSplit = text.split(' ');

    return textSplit[4];
  }
}
