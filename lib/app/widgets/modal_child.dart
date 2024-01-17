part of 'widgets.dart';

class ModalChild extends StatelessWidget {
  const ModalChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 25,
          left: 25,
          right: 25,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(12))),
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Choose the child to be reviewed',
                  style: boldNunitoFontStyle.copyWith(
                    fontSize: 16,
                    color: blackColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset('assets/icons/ic_close.svg'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // * Content
            Obx(
              () => controller.isLoadingChild.value == true
                  ? makeLoadingIndicator()
                  : Column(
                      children: [
                        for (var child in controller.childs)
                          Container(
                            height: 60,
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(width: 1, color: lightGreenColor),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  Get.back();
                                  controller.child.value = child;
                                  controller.getSummary();
                                  switch (controller.selectedIndex.value) {
                                    case 0:
                                      controller.getAll();
                                      break;
                                    case 1:
                                      controller.getDaily();
                                      break;
                                    case 2:
                                      controller.getMonthly();
                                      break;
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    (child.name! as String).toUpperCase(),
                                    style: boldNunitoFontStyle.copyWith(
                                      fontSize: 16,
                                      color: lightGreenColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
