import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snailly/app/data/models/notification_model.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  var notifications = [].obs;
  var isLoading = false.obs;

  final _endPoint = "notification";

  @override
  void onInit() {
    getNotifications();
    super.onInit();
  }

  Future<void> getNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      isLoading.value = true;
      var response = await http.get(
        Uri.parse(dotenv.get('BASE_URL') + _endPoint),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200) {
        throw "error1";
      }

      isLoading.value = false;
      var data = json.decode(response.body)["data"] as List<dynamic>;

      notifications.value = NotificationModel.fromJsonList(data);
    } catch (err) {
      isLoading.value = false;
      log(err.toString());
    }
  }
}
