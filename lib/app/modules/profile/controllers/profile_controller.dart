import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snailly/app/routes/app_pages.dart';
import 'package:snailly/app/shared/shared.dart';

class ProfileController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confNewPassword = TextEditingController();
  var isLoading = false.obs;
  var isChangePassword = false.obs;

  final _endPointLogout = "auth/logout";
  final _endPointUpdate = "profile/";

  @override
  void onInit() {
    final box = GetStorage();
    final data = box.read("dataUser") as Map<String, dynamic>;
    namaController.text = data["name"];
    emailController.text = data["email"];
    super.onInit();
  }

  void logout() async {
    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;
    String accessToken = data["token"];
    try {
      var response = await http.post(
          Uri.parse(
            dotenv.get('BASE_URL') + _endPointLogout,
          ),
          headers: {'Authorization': 'Bearer $accessToken'});

      if (response.statusCode != 200) {
        throw "error1";
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('token_firebase');
      Get.offAllNamed(Routes.LOGIN_PARENTS);
    } catch (err) {
      print(err);
    }
  }

  Future updateProfile() async {
    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;
    final dataUser = box.read("dataUser") as Map<String, dynamic>;
    String accessToken = data["token"];

    try {
      isLoading.value = true;
      var body = {
        "name": namaController.text,
        "email": emailController.text,
      };

      if (oldPassword.text.isNotEmpty) {
        body.addAll({
          "oldPassword": oldPassword.text,
          "newPassword": newPassword.text,
          "confirmPassword": confNewPassword.text,
        });
      }

      var response = await http.put(
        Uri.parse(
          dotenv.get('BASE_URL') + _endPointUpdate + dataUser['id'],
        ),
        headers: {'Authorization': 'Bearer $accessToken'},
        body: body,
      );

      print(response.body);

      if (response.statusCode == 200) {
        showSnackBar("Update Profile Successfully!", status: "Berhasil");
        isLoading.value = false;

        box.write('dataUser', {
          'id': dataUser['id'],
          'email': emailController.text,
          'name': namaController.text,
        });

        if (newPassword.text.isNotEmpty) {
          final dataParent = box.read("dataParent") as Map<String, dynamic>;

          box.write('dataParent', {
            'email': emailController.text,
            'password': newPassword.text,
            'token': dataParent['token'],
            'registrationToken': dataParent['registrationToken'],
          });

          oldPassword.clear();
          newPassword.clear();
          confNewPassword.clear();
        }
      } else {
        isLoading.value = false;
        var messages = json.decode(response.body)["message"];

        if (messages is List) {
          for (var messageData in messages) {
            showSnackBar(messageData['message']);
          }
        } else if (messages is String) {
          showSnackBar(messages);
        } else {
          showSnackBar("Error");
        }
      }
    } catch (err) {
      isLoading.value = false;
      rethrow;
    }
  }

  @override
  void onClose() {
    namaController.dispose();
    emailController.dispose();
    oldPassword.dispose();
    newPassword.dispose();
    confNewPassword.dispose();
    super.onClose();
  }
}
