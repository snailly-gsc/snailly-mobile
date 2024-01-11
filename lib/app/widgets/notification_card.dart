part of 'widgets.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final Function onTap;

  const NotificationCard(
    this.notification, {
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('id', timeago.IdMessages());
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: 'E0E0E0'.toColor(),
            width: 1,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onTap();
          },
          highlightColor: '91A6591A'.toColor(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 16,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 45,
                  height: 45,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: greenColor,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/ic_tindakan_small.svg',
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          notification.title!,
                          style:
                              boldNunitoFontStyle.copyWith(color: blackColor),
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset('assets/icons/ic_circle.svg'),
                        const SizedBox(width: 8),
                        Text(
                          timeago.format(notification.createdAt!, locale: 'id'),
                          style: semiBoldNunitoFontStyle.copyWith(
                            color: yellowColor,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: Text(
                        notification.text!,
                        style:
                            semiBoldNunitoFontStyle.copyWith(color: grayColor),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
