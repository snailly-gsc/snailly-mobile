import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snailly/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:snailly/app/shared/shared.dart';
import 'package:http/http.dart' as http;

class LoginMoveToReportiorController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }

  Future loginToReportior() async {
    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;

    try {
      isLoading.value = true;
      if (passwordController.text == data["password"]) {
        var registrationToken = await getToken();
        final response = await http
            .post(Uri.parse("${dotenv.get('BASE_URL')}auth/login"), body: {
          "email": data['email'],
          "password": passwordController.text,
          "registrationToken": registrationToken
        });

        log(response.body);

        if (response.statusCode == 200) {
          var token = json.decode(response.body)["data"]["accessToken"];
          await checkLogin(token);
          box.write('dataParent', {
            'email': data['email'],
            'password': passwordController.text,
            'token': token,
            'registrationToken': registrationToken,
          });

          showSnackBar("Login Successful", status: "Success");
          isLoading.value = false;
          Get.offAndToNamed(Routes.MAIN);
        } else {
          isLoading.value = false;
          showSnackBar(json.decode(response.body)["message"]);
        }
      } else {
        showSnackBar("Incorrect password");
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<String?> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token_firebase', token!);
    log("FCM $token");

    return token;
  }

  checkLogin(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    log(token.toString());
  }
}
