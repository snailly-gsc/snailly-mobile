part of 'widgets.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final String description;
  // final bool isNegative;
  final StatusLog statusLog;
  final bool isGrantAccess;
  final bool isLast;
  final Function(String) onUpdateGrantAccess;

  const ActivityCard({
    super.key,
    required this.title,
    required this.description,
    required this.onUpdateGrantAccess,
    this.statusLog = StatusLog.unknown,
    this.isGrantAccess = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 75 : 15),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [defaultBoxShadow],
      ),
      child: Row(
        children: [
          // * Emoji
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: statusLog == StatusLog.unknown
                  ? 'FFD493'.toColor().withOpacity(.25)
                  : statusLog == StatusLog.positive
                      ? '097BFD'.toColor().withOpacity(.15)
                      : 'FFE2E2'.toColor(),
            ),
            child: Center(
              child: SvgPicture.asset(
                statusLog == StatusLog.unknown
                    ? 'assets/icons/ic_unknown.svg'
                    : statusLog == StatusLog.positive
                        ? 'assets/icons/ic_positive.svg'
                        : 'assets/icons/ic_negative.svg',
              ),
            ),
          ),
          const SizedBox(width: 15),
          // * Body
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.55,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.PREVIEW_WEBSITE, arguments: title);
                  },
                  child: Text(
                    title.truncateString(),
                    style: boldNunitoFontStyle.copyWith(color: blackColor),
                  ),
                ),
              ),
              Text(
                description,
                style: semiBoldNunitoFontStyle.copyWith(color: grayColor),
              ),
            ],
          ),
          // * Grant Access
          GestureDetector(
            onTap: () {
              onUpdateGrantAccess(isGrantAccess ? 'False' : 'True');
            },
            child: SvgPicture.asset(isGrantAccess
                ? 'assets/icons/ic_unlock.svg'
                : 'assets/icons/ic_lock.svg'),
          ),
        ],
      ),
    );
  }
}
