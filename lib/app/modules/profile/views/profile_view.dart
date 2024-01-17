import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:snailly/app/animations/animations.dart';
import 'package:snailly/app/shared/shared.dart';
import 'package:snailly/app/widgets/widgets.dart';
import 'package:supercharged/supercharged.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  final controller = Get.put(ProfileController());
  ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(defaultPadding),
              color: darkGreenColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Profile",
                    style: extraBoldNunitoFontStyle.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // * Name
                  Text(
                    'Name',
                    style: boldNunitoFontStyle.copyWith(color: blackColor),
                  ),
                  const SizedBox(height: 8),
                  InputText(
                    controller: controller.namaController,
                    hint: 'Type name here',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name cannot be empty';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // * Email
                  Text(
                    'Email',
                    style: boldNunitoFontStyle.copyWith(color: blackColor),
                  ),
                  const SizedBox(height: 8),
                  InputText(
                    controller: controller.emailController,
                    hint: 'Type email here',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email cannot be empty';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Text(
                          'Edit Password?',
                          style: boldNunitoFontStyle.copyWith(
                            color: successColor,
                          ),
                        ),
                        onTap: () {
                          controller.isChangePassword.value = true;
                        },
                      ),
                      Obx(
                        () => controller.isChangePassword.value == true
                            ? GestureDetector(
                                child: SvgPicture.asset(
                                    'assets/icons/ic_close.svg'),
                                onTap: () {
                                  controller.isChangePassword.value = false;
                                },
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Obx(
                    () => controller.isChangePassword.value == true
                        ? FadeAnimation(
                            isTranslate: true,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // * Old Password
                                Text(
                                  'Old Password',
                                  style: boldNunitoFontStyle.copyWith(
                                      color: blackColor),
                                ),
                                const SizedBox(height: 8),
                                InputPassword(
                                  controller: controller.oldPassword,
                                  hint: 'Type your password here',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password cannot be empty';
                                    } else if (value.length < 8) {
                                      return 'Password must be at least 8 characters';
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                // * New Password
                                Text(
                                  'New Password',
                                  style: boldNunitoFontStyle.copyWith(
                                      color: blackColor),
                                ),
                                const SizedBox(height: 8),
                                InputPassword(
                                  controller: controller.newPassword,
                                  hint: 'Type your password here',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password cannot be empty';
                                    } else if (value.length < 8) {
                                      return 'Password must be at least 8 characters';
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                // * Confirm New Password
                                Text(
                                  'Confirm New Password',
                                  style: boldNunitoFontStyle.copyWith(
                                      color: blackColor),
                                ),
                                const SizedBox(height: 8),
                                InputPassword(
                                  controller: controller.confNewPassword,
                                  hint: 'Type your password here',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Password cannot be empty';
                                    } else if (value.length < 8) {
                                      return 'Password must be at least 8 characters';
                                    } else if (controller.newPassword.text !=
                                        value) {
                                      return 'Password and password confirmation do not match';
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(height: 24),
                              ],
                            ),
                          )
                        : const SizedBox(),
                  ),
                  Obx(
                    () => controller.isLoading.value == true
                        ? makeLoadingIndicator()
                        : Button(
                            text: 'Apply',
                            onTap: () {
                              if (controller.formKey.currentState!.validate()) {
                                controller.updateProfile();
                              }
                            },
                          ),
                  ),
                  const SizedBox(height: 24),
                  Divider(
                    color: 'EEEEEE'.toColor(),
                    height: 1,
                  ),
                  const SizedBox(height: 22),
                  Button(
                    text: 'Logout',
                    buttonStyle: makeButton(redColor),
                    onTap: () {
                      controller.logout();
                    },
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
