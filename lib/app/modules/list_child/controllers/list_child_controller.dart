// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;
import '../../../data/models/child.dart';
import '../../../utils/constanta.dart';

class ListChildController extends GetxController {
  final _endPoint = "child";
  var models;

  Future<List<Child>> getChilds() async {
    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;
    String accessToken = data["token"];

    try {
      var response = await http.get(
          Uri.parse(
            baseUrl + _endPoint,
          ),
          headers: {'Authorization': 'Bearer $accessToken'});
      // print(response.body);
      if (response.statusCode != 200) {
        throw "error1";
      }

      var data = json.decode(response.body)["data"] as List<dynamic>;
      models = Child.fromJsonList(data);
    } catch (err) {
      log(err.toString());
    }
    return models;
  }
}
