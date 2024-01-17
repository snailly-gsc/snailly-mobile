import 'dart:developer';

import 'package:snailly/app/data/models/child.dart';
import 'package:snailly/app/routes/app_pages.dart';
import 'package:snailly/app/utils/size_config.dart';
import 'package:snailly/app/utils/style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/choose_child_name_controller.dart';

class ChooseChildNameView extends GetView<ChooseChildNameController> {
  const ChooseChildNameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // var token = Get.arguments;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Image.asset(
                "assets/images/logo_white.png",
                width: Get.width * 0.5,
                fit: BoxFit.contain,
              ),
              // Text("Token :" + token),
              const Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Silahkan pilih nama anda untuk login ",
                    style: kTextStyleColor.copyWith(
                        fontSize: getProportionateScreenWidth(40)),
                  ),
                  Image.asset(
                    "assets/images/ic_child.png",
                    width: Get.width * 0.07,
                    fit: BoxFit.contain,
                    // height: 10,
                  )
                ],
              ),
              const Spacer(
                flex: 2,
              ),
              SizedBox(
                  height: Get.height * 0.4,
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
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(40)),
                            child: InkWell(
                              onTap: () {
                                log(child.name.toString());
                                // controller
                                //     .sendDataToFirebase(child.name.toString());

                                Get.toNamed(Routes.SURFIOR, arguments: child);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: getProportionateScreenHeight(10)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent,
                                  border:
                                      Border.all(color: kwhiteColor, width: 3),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            getProportionateScreenHeight(20)),
                                    child: Text(
                                      child.name.toString().toUpperCase(),
                                      style: kTextStyleColor.copyWith(
                                        fontSize:
                                            getProportionateScreenWidth(45),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
