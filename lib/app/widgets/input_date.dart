part of 'widgets.dart';

enum DateType {
  daily,
  monthly,
}

class InputDate extends StatelessWidget {
  final DateType dateType;
  final DateTime selectedDate;
  final Function(DateTime) onTap;

  const InputDate(
    this.selectedDate, {
    super.key,
    required this.dateType,
    required this.onTap,
  });

  const InputDate.daily(
    this.selectedDate, {
    super.key,
    required this.onTap,
  }) : dateType = DateType.daily;

  const InputDate.monthly(
    this.selectedDate, {
    super.key,
    required this.onTap,
  }) : dateType = DateType.monthly;

  void getPicker(BuildContext context) async {
    switch (dateType) {
      case DateType.daily:
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(1950),
          lastDate: DateTime(2100),
          builder: (context, child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary: lightGreenColor,
                  onPrimary: Colors.white,
                  surface: lightGreenColor,
                  onSurface: Colors.black,
                ),
                dialogBackgroundColor: Colors.white,
              ),
              child: child!,
            );
          },
        );

        if (date != null) {
          onTap(date);
        }
        break;
      default:
        showMonthPicker(
          context: context,
          initialDate: selectedDate,
          headerColor: lightGreenColor,
          selectedMonthBackgroundColor: lightGreenColor,
          unselectedMonthTextColor: lightGreenColor,
        ).then((date) {
          if (date != null) {
            onTap(date);
          }
        });
    }
  }

  String getDate() {
    switch (dateType) {
      case DateType.daily:
        return selectedDate.dateYear;
      default:
        return selectedDate.monthYear;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: lightGrayColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: 'E0E0E0'.toColor(), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () => getPicker(context),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getDate(),
                  style: mediumNunitoFontStyle.copyWith(
                    fontSize: 16,
                    color: '424242'.toColor(),
                  ),
                ),
                SvgPicture.asset('assets/icons/ic_date.svg'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
