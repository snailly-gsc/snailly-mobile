import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:snailly/app/shared/shared.dart';
import 'package:snailly/app/widgets/widgets.dart';
import '../controllers/register_parent_controller.dart';

class RegisterParentView extends GetView<RegisterParentController> {
  const RegisterParentView({Key? key}) : super(key: key);
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
                          "assets/images/bg_circle_small.png",
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? 350
                              : 275,
                          fit: BoxFit.fill,
                        ),
                        // * Title
                        Center(
                          child: Column(
                            children: [
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 8),
                              Text(
                                "Registrasi Akun",
                                textAlign: TextAlign.center,
                                style: headingPrimaryFontStyle,
                              ),
                              Text(
                                "Daftar di sini untuk memantau anak-anak",
                                textAlign: TextAlign.center,
                                style: headingSecondaryFontStyle,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    // * Form
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // * Nama
                          Text(
                            'Nama',
                            style:
                                boldNunitoFontStyle.copyWith(color: blackColor),
                          ),
                          const SizedBox(height: 8),
                          InputText(
                            controller: controller.namaController,
                            hint: 'Tulis nama di sini',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Nama tidak boleh kosong';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
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
                          const SizedBox(height: 16),
                          // * Konfirmasi Password
                          Text(
                            'Konfirmasi Password',
                            style:
                                boldNunitoFontStyle.copyWith(color: blackColor),
                          ),
                          const SizedBox(height: 8),
                          InputPassword(
                            controller: controller.confPasswordController,
                            hint: 'Tulis password di sini',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password tidak boleh kosong';
                              } else if (value.length < 8) {
                                return 'Password minimal 8 karakter';
                              } else if (controller.passwordController.text !=
                                  value) {
                                return 'Password dan konfirmasi password tidak sesuai';
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          // * Button
                          Button(
                            text: 'Daftar',
                            onTap: () async {
                              if (controller.formKey.currentState!.validate()) {
                                controller.registerAccountParent();
                              }
                            },
                          ),
                          const SizedBox(height: 15),
                          // * Move to login
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sudah punya akun?',
                                style: semiBoldNunitoFontStyle.copyWith(
                                    color: grayColor),
                              ),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Text(
                                  'Masuk',
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
