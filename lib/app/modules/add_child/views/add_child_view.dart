// ignore_for_file: unused_local_variable

import 'package:snailly/app/modules/home/views/component_home/default_button.dart';
import 'package:snailly/app/utils/size_config.dart';
import 'package:snailly/app/utils/style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_child_controller.dart';

class AddChildView extends GetView<AddChildController> {
  const AddChildView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var token = Get.arguments;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20),
              vertical: getProportionateScreenHeight(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Child",
                style: kTextStyleColor3.copyWith(
                  fontSize: getProportionateScreenWidth(55),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              TextFormField(
                // style: const TextStyle(color: Colors.white),
                controller: controller.nameController,
                decoration: InputDecoration(
                  hintText: "Enter your name child",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                children: [
                  Expanded(
                      child: DefaultButton(
                          text: "BATAL",
                          color: Colors.red,
                          press: () => Get.back())),
                  SizedBox(width: getProportionateScreenWidth(20)),
                  Expanded(
                      child: DefaultButton(
                          text: "TAMBAH",
                          color: kPrimaryColor,
                          press: () => controller.registerChild())),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
