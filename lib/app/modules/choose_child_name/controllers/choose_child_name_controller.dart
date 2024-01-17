// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:snailly/app/data/models/child.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ChooseChildNameController extends GetxController {
  final _endPoint = "child";
  var models;
  // String? token;
  // void getToken() async {
  //   token = await FirebaseMessaging.instance.getToken();
  //   log("TOKEN FIREBASE");
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('token_firebase', token!);
  //   log(token.toString());
  // }

  Future<List<Child>> getChilds() async {
    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;
    String accessToken = data["token"];

    try {
      var response = await http.get(
          Uri.parse(
            dotenv.get('BASE_URL') + _endPoint,
          ),
          headers: {'Authorization': 'Bearer $accessToken'});
      // print(response.body);
      if (response.statusCode != 200) {
        throw "error1";
      }

      var data = json.decode(response.body)["data"] as List<dynamic>;
      models = Child.fromJsonList(data);
    } catch (err) {
      log('error: $err');
    }
    return models;
  }

  @override
  void onInit() async {
    // await GetStorage.init();
    super.onInit();
  }
}
