import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'package:snailly/app/data/models/global.dart';
import 'package:snailly/app/routes/app_pages.dart';

class AppLinkService {
  Future<void> initDeepLinks() async {
    var appLinks = AppLinks();

    // Check initial link if app was in cold state (terminated)
    final appLink = await appLinks.getInitialAppLink();
    if (appLink != null) {
      print('getInitialAppLink: $appLink');
      openAppLink(appLink);
    }

    // Handle link when app is in warm state (front or background)
    var linkSubscription = appLinks.uriLinkStream.listen((uri) {
      print('onAppLink: $uri');
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    Global.url = uri;
    Get.toNamed(Routes.CHOOSE_CHILD);
  }
}
