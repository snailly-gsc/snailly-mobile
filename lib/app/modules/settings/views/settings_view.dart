import 'package:snailly/app/modules/home/views/component_home/default_button.dart';
import 'package:snailly/app/utils/size_config.dart';
import 'package:snailly/app/utils/style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(100)),
                  child: Text(
                    "Setting",
                    style: kTextStyleColor3.copyWith(
                      fontSize: getProportionateScreenWidth(72),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  readOnly: true,
                  initialValue: controller.emailController.text,
                  decoration: InputDecoration(
                    fillColor: kPrimaryColor,
                    filled: true,
                    hintText: "Enter your email",
                    hintStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                TextFormField(
                  obscureText: true,
                  controller: controller.oldPasswordController,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    fillColor: kPrimaryColor,
                    filled: true,
                    hintText: "Enter Old password",
                    hintStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                TextFormField(
                  obscureText: true,
                  controller: controller.newPasswordController,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    fillColor: kPrimaryColor,
                    filled: true,
                    hintText: "Enter New password",
                    hintStyle: const TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                DefaultButton(
                    text: "Change Setting",
                    color: kPrimaryColor,
                    press: () => controller.changePassword()),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
