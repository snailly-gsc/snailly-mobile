import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:snailly/app/data/models/child.dart';
import 'package:snailly/app/modules/main/controllers/main_controller.dart';
import 'package:snailly/app/shared/shared.dart';
import 'package:supercharged/supercharged.dart';

class ChildController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formEditKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController namaEditController = TextEditingController();
  final controller = Get.put(MainController());
  var childs = [].obs;

  final _endPoint = "child/";

  Future<void> getChilds() async {
    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;
    String accessToken = data["token"];

    try {
      controller.isLoading.value = true;
      var response = await http.get(
          Uri.parse(
            dotenv.get('BASE_URL') + _endPoint,
          ),
          headers: {'Authorization': 'Bearer $accessToken'});

      if (response.statusCode != 200) {
        throw "error1";
      }

      controller.isLoading.value = false;
      var data = json.decode(response.body)["data"] as List<dynamic>;

      childs.value = Child.fromJsonList(data);
    } catch (err) {
      controller.isLoading.value = false;
      showSnackBar(err.toString());
    }
  }

  Future<void> createChild() async {
    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;
    String accessToken = data["token"];
    try {
      if (namaController.text.isNotEmpty) {
        controller.isLoading.value = true;

        final response = await http.post(
          Uri.parse(dotenv.get('BASE_URL') + _endPoint),
          headers: {'Authorization': 'Bearer $accessToken'},
          body: {
            'name': namaController.text,
          },
        );

        if (response.statusCode == 200) {
          controller.isLoading.value = false;
          namaController.clear();
          showSnackBar("Successfully add child data", status: "Success");
          getChilds();
        } else {
          controller.isLoading.value = false;
          var messages = json.decode(response.body)["message"];

          if (messages is List) {
            for (var messageData in messages) {
              showSnackBar(messageData['message']);
            }
          } else {
            showSnackBar(messages);
          }
        }
      } else {
        showSnackBar("The name cannot be empty!");
      }
    } catch (err) {
      controller.isLoading.value = false;
      showSnackBar(err.toString());
    }
  }

  Future<void> deleteChild(Child child) async {
    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;
    String accessToken = data["token"];
    try {
      controller.isLoading.value = true;

      final response = await http.delete(
        Uri.parse(dotenv.get('BASE_URL') + _endPoint + child.id!),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode != 200) {
        throw "Child data cannot be deleted";
      }

      controller.isLoading.value = false;
      openDialogSuccess('Successfully delete data');
      getChilds();
    } catch (err) {
      controller.isLoading.value = false;
      showSnackBar(err.toString());
    }
  }

  Future<void> editChild(Child child) async {
    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;
    String accessToken = data["token"];
    try {
      if (namaEditController.text.isNotEmpty) {
        controller.isLoading.value = true;

        final response = await http.put(
          Uri.parse(dotenv.get('BASE_URL') + _endPoint + child.id!),
          headers: {'Authorization': 'Bearer $accessToken'},
          body: {
            'name': namaEditController.text,
          },
        );

        if (response.statusCode == 200) {
          controller.isLoading.value = false;
          namaEditController.clear();
          openDialogSuccess('Edit data success');
          getChilds();
        } else {
          controller.isLoading.value = false;
          var messages = json.decode(response.body)["message"];

          if (messages is List) {
            for (var messageData in messages) {
              showSnackBar(messageData['message']);
            }
          } else {
            showSnackBar(messages);
          }
        }
      } else {
        showSnackBar("The name cannot be empty!");
      }
    } catch (err) {
      controller.isLoading.value = false;
      showSnackBar(err.toString());
    }
  }

  void openDialogSuccess(String text) {
    Get.dialog(
      AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 70),
        contentPadding: const EdgeInsets.all(16),
        content: SizedBox(
          height: 100,
          child: Column(
            children: [
              Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: 'D6F7D9'.toColor(),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset('assets/icons/ic_success.svg'),
              ),
              const SizedBox(height: 10),
              Text(
                text,
                textAlign: TextAlign.center,
                style: boldNunitoFontStyle.copyWith(
                  color: blackColor,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onClose() {
    namaController.dispose();
    super.onClose();
  }
}
