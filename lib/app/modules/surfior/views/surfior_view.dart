import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:snailly/app/animations/animations.dart';
import 'package:snailly/app/routes/app_pages.dart';
import 'package:snailly/app/shared/shared.dart';
import 'package:snailly/app/widgets/widgets.dart';
import 'package:supercharged/supercharged.dart';

import '../controllers/surfior_controller.dart';

class SurfiorView extends GetView<SurfiorController> {
  const SurfiorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatusBar(
      brightness: Brightness.dark,
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/bg_surfior.png",
                fit: BoxFit.fill,
              ),
            ),
            FadeAnimation(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset("assets/images/snailly_surfior.png"),
              ),
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin:
                        const EdgeInsets.only(top: 40, right: 50, bottom: 50),
                    child: SvgPicture.asset("assets/images/circle_surfior.svg"),
                  ),
                ),
                FadeAnimation(
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Text(
                      'What do you wanna search, kids?',
                      style: extraBoldNunitoFontStyle.copyWith(
                        color: greenColor,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            FadeAnimation(
              isTranslate: true,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Obx(
                    () => TextFormField(
                      controller: controller.searchController,
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (value) {
                        Get.toNamed(Routes.BROWSER_SURFIOR, arguments: [
                          value,
                          controller.child,
                        ]);
                      },
                      style: mediumNunitoFontStyle.copyWith(
                        fontSize: 18,
                        color: '666666'.toColor(),
                      ),
                      decoration: InputDecoration(
                        suffixIcon: AvatarGlow(
                          animate: controller.isListening.value,
                          glowColor: greenColor,
                          endRadius: 25.0,
                          duration: const Duration(milliseconds: 2000),
                          repeatPauseDuration:
                              const Duration(milliseconds: 100),
                          child: GestureDetector(
                            onTapDown: (_) {
                              controller.isListening.value = true;
                              controller.listen();
                            },
                            onTapUp: (_) {
                              controller.isListening.value = false;
                            },
                            child: Container(
                              width: 50,
                              margin: const EdgeInsets.only(right: 5),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: greenColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                controller.isListening.value
                                    ? Icons.mic
                                    : Icons.mic_none,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                        hintText: "Type or speak it!",
                        hintStyle: mediumNunitoFontStyle.copyWith(
                          fontSize: 18,
                          color: '666666'.toColor(),
                        ),
                        fillColor: whiteColor,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              BorderSide(color: greenColor.withOpacity(.45)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: whiteColor),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
