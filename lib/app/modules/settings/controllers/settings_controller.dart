import 'dart:developer';

import 'package:snailly/app/utils/constanta.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class SettingsController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  final _endpoint = "parent/update-password";

  @override
  void onInit() {
    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;
    String accessToken = data["token"];
    emailController.text = data["email"];
    super.onInit();
  }

  void changePassword() async {
    final box = GetStorage();
    final data = box.read('dataParent');
    String password = data['password'];
    String token = data['token'];

    try {
      if (oldPasswordController.text == password) {
        if (newPasswordController.text.length >= 8) {
          final reponse =
              await http.post(Uri.parse(baseUrl + _endpoint), headers: {
            'Authorization': 'Bearer $token'
          }, body: {
            'email': emailController.text,
            'old_password': oldPasswordController.text,
            'new_password': newPasswordController.text,
          });
          box.write('dataParent', {
            'email': emailController.text,
            'password': newPasswordController.text,
            'token': token,
          });
          Get.snackbar("Success", "Change Password Success");
        } else {
          Get.snackbar("Warning!!!", "Password harus lebih dari 8 character");
        }
      } else {
        Get.snackbar("Warning!!!", "Password not be same!");
      }
    } catch (e) {}
  }

  void testStorage() {
    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;
    String accessToken = data["token"];
    log(data["email"]);

    log("masukan");
  }
}
