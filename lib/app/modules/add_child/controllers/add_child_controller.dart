import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AddChildController extends GetxController {
  TextEditingController nameController = TextEditingController();

  final _endPoint = "child";
  Future registerChild() async {
    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;
    String accessToken = data["token"];
    try {
      if (nameController.text.isNotEmpty) {
        final response = await http.post(
          Uri.parse(dotenv.get('BASE_URL') + _endPoint),
          headers: {'Authorization': 'Bearer $accessToken'},
          body: {
            'name': nameController.text,
          },
        );
        // print(response.body);
        if (response.statusCode == 200) {
          Get.snackbar("Success", "Success add childs");
          clearTexfiled();
        }
      } else {
        Get.snackbar("Warning", "Nama tidak boleh kosong!!");
      }
    } catch (e) {
      rethrow;
    }
  }

  void clearTexfiled() {
    nameController.clear();
  }
}
