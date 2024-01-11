import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:snailly/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:snailly/app/services/app_link_service.dart';

class SplashScreenController extends GetxController {
  final _endPoint = "auth/me";

  moveToHome() async {
    bool isLogin = await getCurrentUser();

    Future.delayed(const Duration(seconds: 2), () async {
      if (isLogin) {
        Get.offAllNamed(Routes.CHOOSE_USER);
        await AppLinkService().initDeepLinks();
      } else {
        Get.offAllNamed(Routes.LOGIN_PARENTS);
      }
    });
  }

  Future<bool> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      log('token: $token');

      var response = await http.get(
          Uri.parse(
            dotenv.get('BASE_URL') + _endPoint,
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

      return true;
    } catch (err) {
      log(err.toString());
      return false;
    }
  }
}
