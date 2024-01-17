import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:snailly/app/shared/shared.dart';
import 'package:snailly/app/widgets/widgets.dart';

import '../controllers/child_controller.dart';

class ChildView extends StatelessWidget {
  final controller = Get.put(ChildController());
  ChildView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // * Form
          Form(
            key: controller.formKey,
            child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              color: darkGreenColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "Manage Children Data",
                    style: extraBoldNunitoFontStyle.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 25),
                  // * Form Child
                  Text('Child Name', style: boldNunitoFontStyle),
                  const SizedBox(height: 8),
                  InputTextWhite(
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
                  // * Button
                  Button(
                    text: 'Add Child',
                    onTap: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.createChild();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          // * Child List
          Obx(
            () => Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Child List',
                    style: boldNunitoFontStyle.copyWith(
                      color: blackColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  for (var child in controller.childs)
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ChildCard(
                        child,
                        onDelete: (child) async {
                          Get.back();
                          await controller.deleteChild(child);
                        },
                        onEdit: (child) async {
                          Get.back();
                          await controller.editChild(child);
                        },
                      ),
                    ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
