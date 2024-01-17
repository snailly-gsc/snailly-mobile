import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:snailly/app/data/models/child.dart';
import 'package:http/http.dart' as http;
import 'package:snailly/app/data/models/log_activity_model.dart';
import 'package:snailly/app/data/models/summary.dart';
import 'package:snailly/app/shared/shared.dart';
import 'package:snailly/app/utils/constanta.dart';
import 'package:snailly/app/widgets/widgets.dart';
import 'package:supercharged/supercharged.dart';

class HomeController extends GetxController {
  // End Point
  final _endPointChild = "child";
  final _endPointSummary = "log/summary/";
  final _endPointLog = "log/";
  final _endPointGrantAccess = "log/grant-access/";

  // Controller
  final scrollController = ScrollController();

  // Tab Navigation
  var selectedIndex = 0.obs;

  // Child
  var childs = [].obs;
  var child = Child(id: 'ALL', name: 'Semua').obs;
  var isLoadingChild = false.obs;

  // Summary
  var summary = Summary().obs;
  var isLoadingSummary = false.obs;

  // Log
  var logs = [].obs;
  var page = 1.obs;
  var limit = 10.obs;
  var totalPage = 1.obs;
  var isLoadingLog = false.obs;
  var selectedDate = DateTime.now().obs;

  @override
  void onInit() async {
    super.onInit();
    scrollController.addListener(onScroll);
    await getSummary();
    await getAll();
    await getChilds();
  }

  void onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;

    if (currentScroll == maxScroll && page.value < totalPage.value) {
      page.value++;
      switch (selectedIndex.value) {
        case 0:
          getAll();
          break;
        case 1:
          getDaily();
          break;
        case 2:
          getMonthly();
          break;
      }
    }
  }

  void clearLogs() {
    logs.clear();
    page.value = 1;
    totalPage.value = 1;
  }

  Future<void> getChilds() async {
    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;
    String accessToken = data["token"];

    try {
      isLoadingChild.value = true;
      var response = await http.get(
          Uri.parse(
            baseUrl + _endPointChild,
          ),
          headers: {'Authorization': 'Bearer $accessToken'});

      if (response.statusCode != 200) {
        throw response.body;
      }

      isLoadingChild.value = false;
      var data = json.decode(response.body)["data"] as List<dynamic>;

      childs.value = [Child(id: 'ALL', name: 'Semua')];
      childs.addAll(Child.fromJsonList(data));
    } catch (err) {
      isLoadingChild.value = false;
      log(err.toString());
    }
  }

  Future<void> getSummary() async {
    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;
    String accessToken = data["token"];

    try {
      isLoadingSummary.value = true;
      var response = await http.get(
          Uri.parse(
            baseUrl + _endPointSummary + child.value.id!,
          ),
          headers: {'Authorization': 'Bearer $accessToken'});

      if (response.statusCode != 200) {
        throw response.body;
      }

      isLoadingSummary.value = false;
      var data = json.decode(response.body)["data"];
      summary.value = Summary.fromJson(data);
    } catch (err) {
      isLoadingSummary.value = false;
      log(err.toString());
    }
  }

  Future<void> getAll() async {
    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;
    String accessToken = data["token"];

    try {
      var response = await http.get(
        Uri.parse(
          '$baseUrl$_endPointLog${child.value.id!}?page=${page.value}&limit=${limit.value}',
        ),
        headers: {'Authorization': 'Bearer $accessToken'},
      );

      if (response.statusCode != 200) {
        throw response.body;
      }

      var data = json.decode(response.body)["data"]["items"] as List<dynamic>;
      totalPage.value = json.decode(response.body)["data"]["totalPage"] as int;

      logs.addAll(LogActivityModel.fromJsonList(data));
    } catch (err) {
      log(err.toString());
    }
  }

  Future<void> getDaily() async {
    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;
    String accessToken = data["token"];

    DateTime newDate = selectedDate.value.subtract(const Duration(days: 1));

    print(
        '$baseUrl$_endPointLog${child.value.id!}?period=daily&date=${newDate.day}&month=${newDate.month}&year=${newDate.year}&page=${page.value}&limit=${limit.value}');

    try {
      var response = await http.get(
          Uri.parse(
            '$baseUrl$_endPointLog${child.value.id!}?period=daily&date=${newDate.day}&month=${newDate.month}&year=${newDate.year}&page=${page.value}&limit=${limit.value}',
          ),
          headers: {'Authorization': 'Bearer $accessToken'});

      if (response.statusCode != 200) {
        throw response.body;
      }

      var data = json.decode(response.body)["data"]["items"] as List<dynamic>;
      totalPage.value = json.decode(response.body)["data"]["totalPage"] as int;

      logs.addAll(LogActivityModel.fromJsonList(data));
    } catch (err) {
      log(err.toString());
    }
  }

  Future<void> getMonthly() async {
    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;
    String accessToken = data["token"];

    print(
        '$baseUrl$_endPointLog${child.value.id!}?period=monthly&month=${selectedDate.value.month}&year=${selectedDate.value.year}&page=${page.value}&limit=${limit.value}');

    try {
      var response = await http.get(
          Uri.parse(
            '$baseUrl$_endPointLog${child.value.id!}?period=monthly&month=${selectedDate.value.month}&year=${selectedDate.value.year}&page=${page.value}&limit=${limit.value}',
          ),
          headers: {'Authorization': 'Bearer $accessToken'});

      if (response.statusCode != 200) {
        throw response.body;
      }

      var data = json.decode(response.body)["data"]["items"] as List<dynamic>;
      totalPage.value = json.decode(response.body)["data"]["totalPage"] as int;

      logs.addAll(LogActivityModel.fromJsonList(data));
    } catch (err) {
      log(err.toString());
    }
  }

  Future<void> updateGrantAccess(String id, String isAllow) async {
    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;
    String accessToken = data["token"];
    try {
      isLoadingLog.value = true;

      final response = await http.put(
        Uri.parse(baseUrl + _endPointGrantAccess + id),
        headers: {'Authorization': 'Bearer $accessToken'},
        body: {
          "grantAccess": isAllow,
        },
      );

      if (response.statusCode != 200) {
        throw (json.decode(response.body)["message"]);
      }

      Get.back();
      showSnackBar('Berhasil ubah grant access', status: 'Success');
    } catch (err) {
      isLoadingLog.value = false;
      showSnackBar(err.toString());
    }
  }

  void openDialogGrantAccess(String id, String isAllow, String report) {
    Get.dialog(
      AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 50),
        contentPadding: const EdgeInsets.all(16),
        content: SizedBox(
          height: 220,
          child: Column(
            children: [
              Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: 'FFD49340'.toColor(),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset('assets/icons/ic_warning.svg'),
              ),
              const SizedBox(height: 10),
              Text(
                isAllow == 'True'
                    ? 'Yakin untuk Buka Kunci Website?'
                    : 'Yakin untuk Kunci Website?',
                textAlign: TextAlign.center,
                style: boldNunitoFontStyle.copyWith(
                  color: blackColor,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isAllow == 'True'
                    ? 'Domain dengan website tersebut akan di kunci bisa di akses'
                    : 'Domain dengan website tersebut akan di kunci tidak bisa di akses',
                textAlign: TextAlign.center,
                style: boldNunitoFontStyle.copyWith(color: grayColor),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 125,
                    height: 45,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: grayColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 5,
                        ),
                        backgroundColor: Colors.transparent,
                        side: BorderSide(color: grayColor, width: 1),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                      ),
                      child: Text('Batal',
                          style: boldNunitoFontStyle.copyWith(
                            color: grayColor,
                          )),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Button(
                    text: 'Ya',
                    width: 125,
                    height: 45,
                    buttonStyle: makeButton(lightGreenColor, borderRadius: 6),
                    onTap: () async {
                      await updateGrantAccess(id, isAllow);
                      clearLogs();
                      Get.back();
                      switch (report) {
                        case 'all':
                          getAll();
                          break;
                        case 'daily':
                          getDaily();
                          break;
                        case 'monthly':
                          getMonthly();
                          break;
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
