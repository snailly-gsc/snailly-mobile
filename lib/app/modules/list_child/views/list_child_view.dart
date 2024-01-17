import 'dart:developer';

import 'package:snailly/app/modules/home/views/component_home/default_button.dart';
import 'package:snailly/app/routes/app_pages.dart';
import 'package:snailly/app/utils/size_config.dart';
import 'package:snailly/app/utils/style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/child.dart';
import '../controllers/list_child_controller.dart';

class ListChildView extends GetView<ListChildController> {
  const ListChildView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var token = Get.arguments;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(32)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(20)),
                child: Text(
                  "Child`s Name:",
                  style: kTextStyleColor3.copyWith(
                    fontSize: getProportionateScreenWidth(60),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                  height: Get.width * 1,
                  child: FutureBuilder<List<Child>>(
                    future: controller.getChilds(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snapshot.hasData) {
                        return const Center(
                          child: Text("Tidak ada data..."),
                        );
                      }

                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Child child = snapshot.data![index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            // height: 50,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: kPrimaryColor.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(20)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    child.name.toString(),
                                    // softWrap: true,
                                    overflow: TextOverflow.visible,
                                    style: kTextStyleColor3.copyWith(
                                      fontSize: getProportionateScreenWidth(50),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Image.asset(
                                          "assets/icons/icon_edit.png",
                                          width:
                                              getProportionateScreenWidth(50),
                                          height:
                                              getProportionateScreenWidth(50),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            log(child.id.toString()),
                                        icon: Image.asset(
                                          "assets/icons/icon_delete.png",
                                          width:
                                              getProportionateScreenWidth(50),
                                          height:
                                              getProportionateScreenWidth(50),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(left: Get.width * 0.5),
                child: DefaultButton(
                  text: "Add New Child",
                  color: kPrimaryColor,
                  press: () => Get.toNamed(Routes.ADD_CHILD, arguments: token),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
