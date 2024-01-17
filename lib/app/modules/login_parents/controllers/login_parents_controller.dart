import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:snailly/app/routes/app_pages.dart';
import 'package:snailly/app/shared/shared.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginParentsController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;
  final _endPointUser = "auth/me";

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
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

  Future loginParent() async {
    try {
      isLoading.value = true;
      final response =
          await http.post(Uri.parse("${dotenv.get('BASE_URL')}auth/login"), body: {
        "email": emailController.text,
        "password": passwordController.text,
      });

      log(response.body);

      if (response.statusCode == 200) {
        var token = json.decode(response.body)["data"]["accessToken"];
        await checkLogin(token);
        final box = GetStorage();
        box.write('dataParent', {
          'email': emailController.text,
          'password': passwordController.text,
          'token': token,
        });

        await getCurrentUser();
      } else {
        isLoading.value = false;
        showSnackBar(json.decode(response.body)["message"]);
      }
    } catch (err) {
      isLoading.value = false;
      showSnackBar(err.toString());
    }
  }

  Future<void> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      log('token: $token');

      var response = await http.get(
          Uri.parse(
            dotenv.get('BASE_URL') + _endPointUser,
          ),
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode != 200) {
        throw "error1";
      }

      var data = json.decode(response.body)["data"];
      final box = GetStorage();
      box.write('dataUser', {
        'id': data['id'],
        'email': data['email'],
        'name': data['name'],
      });

      showSnackBar("Login berhasil!", status: "Berhasil");
      isLoading.value = false;
      Get.offAndToNamed(Routes.CHOOSE_USER);
    } catch (err) {
      log(err.toString());
    }
  }
}
