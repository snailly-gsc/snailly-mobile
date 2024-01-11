import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snailly/app/data/models/child.dart';
import 'package:snailly/app/data/models/global.dart';
import 'package:snailly/app/routes/app_pages.dart';

class ChooseChildController extends GetxController {
  final _endPoint = "child";

  var childs = [].obs;
  var isLoading = false.obs;

  Uri? url;

  @override
  void onInit() async {
    super.onInit();
    await getChilds();
  }

  Future<void> getChilds() async {
    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;
    String accessToken = data["token"];

    try {
      isLoading.value = true;
      var response = await http.get(
          Uri.parse(
            dotenv.get('BASE_URL') + _endPoint,
          ),
          headers: {'Authorization': 'Bearer $accessToken'});

      if (response.statusCode != 200) {
        throw "error1";
      }

      print(response.body);

      isLoading.value = false;
      var data = json.decode(response.body)["data"] as List<dynamic>;

      childs.value = Child.fromJsonList(data);
    } catch (err) {
      isLoading.value = false;
      log(err.toString());
    }
  }

  void moveToBrowser(Child child) async {
    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;
    url = Global.url;
    print('url $url');

    var registrationToken = await getToken();
    box.write('dataParent', {
      'email': data['email'],
      'password': data['password'],
      'token': data['token'],
      'registrationToken': data['registrationToken'],
      'registrationTokenChild': registrationToken,
    });

    if (url != null) {
      Get.toNamed(Routes.BROWSER_SURFIOR, arguments: [url.toString(), child]);
    } else {
      Get.toNamed(Routes.SURFIOR, arguments: child);
    }
  }

  Future<String?> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token_firebase', token!);
    log("FCM $token");

    return token;
  }
}
