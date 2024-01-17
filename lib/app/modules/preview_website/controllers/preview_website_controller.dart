import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:snailly/app/utils/style.dart';

class PreviewWebsiteController extends GetxController {
  String search = Get.arguments;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  late PullToRefreshController pullToRefreshController;
  String ulrs = "";
  double progress = 0;
  TextEditingController urlController = TextEditingController();
  List<ContentBlocker> blocker = [];

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: true,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      useOnNavigationResponse: true,
    ),
  );

  @override
  void onInit() {
    super.onInit();
    // populateBlackListUrl();
    pullToRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(
          color: kPrimaryColor,
        ),
        onRefresh: () async {
          if (Platform.isAndroid) {
            webViewController?.reload();
          } else if (Platform.isIOS) {
            webViewController?.loadUrl(
                urlRequest: URLRequest(url: await webViewController?.getUrl()));
          }
        });
  }

  String parseURL() {
    bool is_valid = Uri.parse(search).isAbsolute;
    if (is_valid) {
      return search;
    } else {
      return "https://www.google.com/search?q=$search";
    }
  }
}
