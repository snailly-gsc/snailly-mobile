part of 'widgets.dart';

class ChildCard extends StatelessWidget {
  final Child child;
  final Function(Child) onDelete;
  final Function(Child) onEdit;
  final controller = Get.put(ChildController());
  ChildCard(
    this.child, {
    super.key,
    required this.onDelete,
    required this.onEdit,
  });

  void openDialogWarning(Child child) {
    Get.dialog(
      AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 50),
        contentPadding: const EdgeInsets.all(16),
        content: SizedBox(
          height: 200,
          child: Column(
            children: [
              Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: 'FFD49340'.toColor(),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset('assets/icons/ic_warning.svg'),
              ),
              const SizedBox(height: 10),
              Text(
                'Are sure to delete?',
                textAlign: TextAlign.center,
                style: boldNunitoFontStyle.copyWith(
                  color: blackColor,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Data with child name ${child.name} will be deleted permanently',
                textAlign: TextAlign.center,
                style: boldNunitoFontStyle.copyWith(color: grayColor),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 125,
                    height: 45,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: grayColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 5,
                        ),
                        backgroundColor: Colors.transparent,
                        side: BorderSide(color: grayColor, width: 1),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                      ),
                      child: Text('Cancel',
                          style: boldNunitoFontStyle.copyWith(
                            color: grayColor,
                          )),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  Button(
                    text: 'Sure',
                    width: 125,
                    height: 45,
                    buttonStyle: makeButton(lightGreenColor, borderRadius: 6),
                    onTap: () {
                      onDelete(child);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openDialogEdit(Child child) {
    Get.dialog(
      AlertDialog(
        contentPadding: const EdgeInsets.all(16),
        content: SizedBox(
          width: 600,
          height: 175,
          child: Form(
            key: controller.formEditKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Child Name',
                  style: boldNunitoFontStyle.copyWith(color: blackColor),
                ),
                const SizedBox(height: 8),
                InputText(
                  controller: controller.namaEditController,
                  hint: 'Type name here',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name cannot be empty';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 135,
                      height: 45,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: grayColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 5,
                          ),
                          backgroundColor: Colors.transparent,
                          side: BorderSide(color: grayColor, width: 1),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                        ),
                        child: Text('Cancel',
                            style: boldNunitoFontStyle.copyWith(
                              color: grayColor,
                            )),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    Button(
                      text: 'Edit',
                      width: 135,
                      height: 45,
                      buttonStyle: makeButton(lightGreenColor, borderRadius: 6),
                      onTap: () {
                        if (controller.formEditKey.currentState!.validate()) {
                          onEdit(child);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [defaultBoxShadow],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: greenColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/ic_child.svg',
                    width: 25,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                child.name!,
                style: boldNunitoFontStyle.copyWith(
                  color: blackColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(
            color: 'EEEEEE'.toColor(),
            height: 1,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Button(
                text: 'Edit',
                width: 90,
                height: 40,
                onTap: () {
                  controller.namaEditController.text = child.name!;
                  openDialogEdit(child);
                },
              ),
              const SizedBox(width: 12),
              Button(
                text: 'Delete',
                buttonStyle: makeButton(redColor),
                width: 90,
                height: 40,
                onTap: () {
                  openDialogWarning(child);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
