import 'dart:convert';
import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:snailly/app/shared/shared.dart';

class RegisterParentController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPasswordController = TextEditingController();
  RxBool isLoading = false.obs;

  final _endPoint = "auth/register";

  Future<void> registerAccountParent() async {
    if (emailController.text.isNotEmpty &&
        EmailValidator.validate(emailController.text)) {
      try {
        isLoading.value = true;
        final response = await http
            .post(Uri.parse(dotenv.get('BASE_URL') + _endPoint), body: {
          "name": namaController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "confirmPassword": confPasswordController.text,
        });

        if (response.statusCode == 200) {
          isLoading.value = false;
          Get.back();
          showSnackBar("Berhasil membuat akun orang tua", status: "Berhasil");
          log(response.body);
        } else {
          isLoading.value = false;
          log(response.body);
          var messages = json.decode(response.body)["message"];

          if (messages is List) {
            for (var messageData in messages) {
              showSnackBar(messageData['message']);
            }
          } else {
            showSnackBar(messages);
          }
        }
      } catch (err) {
        showSnackBar(err.toString());
      }
    } else {
      showSnackBar("Format email tidak sesuai!!");
    }

    isLoading.value = false;
  }

  @override
  void onClose() {
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confPasswordController.dispose();
    super.onClose();
  }
}
