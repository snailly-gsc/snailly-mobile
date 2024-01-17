// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snailly/app/routes/app_pages.dart';
import 'package:snailly/app/shared/shared.dart';
import 'package:snailly/app/widgets/widgets.dart';
import '../controllers/login_parents_controller.dart';

class LoginParentsView extends GetView<LoginParentsController> {
  const LoginParentsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StatusBar(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // * Heading
                    Stack(
                      children: [
                        // * Background Circle
                        Image.asset(
                          "assets/images/bg_circle.png",
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? 350
                              : MediaQuery.of(context).size.height / 2,
                          fit: BoxFit.fill,
                        ),
                        // * Title
                        Center(
                          child: Column(
                            children: [
                              // * Title
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 7),
                              Image.asset(
                                "assets/images/logo.png",
                                width: 100,
                                height: 100,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Snailly",
                                textAlign: TextAlign.center,
                                style: headingPrimaryFontStyle,
                              ),
                              Text(
                                "Safe browsing for the children",
                                textAlign: TextAlign.center,
                                style: headingSecondaryFontStyle,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    // * Choose User
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          // * Email
                          Text(
                            'Email',
                            style:
                                boldNunitoFontStyle.copyWith(color: blackColor),
                          ),
                          const SizedBox(height: 8),
                          InputText(
                            controller: controller.emailController,
                            hint: 'Tulis email di sini',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email tidak boleh kosong';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // * Password
                          Text(
                            'Password',
                            style:
                                boldNunitoFontStyle.copyWith(color: blackColor),
                          ),
                          const SizedBox(height: 8),
                          InputPassword(
                            controller: controller.passwordController,
                            hint: 'Tulis password di sini',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password tidak boleh kosong';
                              } else if (value.length < 8) {
                                return 'Password minimal 8 karakter';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          // * Button
                          Button(
                            text: 'Masuk',
                            onTap: () async {
                              if (controller.formKey.currentState!.validate()) {
                                controller.loginParent();
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          // * Move to register
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Tidak Punya Akun?',
                                style: semiBoldNunitoFontStyle.copyWith(
                                    color: grayColor),
                              ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.REGISTER_PARENT);
                                },
                                child: Text(
                                  'Daftar',
                                  style: semiBoldNunitoFontStyle.copyWith(
                                    color: successColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => controller.isLoading.value == true
                  ? const Loading()
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
