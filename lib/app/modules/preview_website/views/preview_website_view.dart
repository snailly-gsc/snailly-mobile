import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';
import 'package:snailly/app/shared/shared.dart';
import 'package:snailly/app/widgets/widgets.dart';

import '../controllers/preview_website_controller.dart';

class PreviewWebsiteView extends GetView<PreviewWebsiteController> {
  const PreviewWebsiteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    key: controller.webViewKey,
                    initialUrlRequest:
                        URLRequest(url: Uri.parse(controller.parseURL())),
                    initialOptions: controller.options,
                    pullToRefreshController: controller.pullToRefreshController,
                    onWebViewCreated: (controllers) {
                      controller.webViewController = controllers;
                    },
                    onLoadStart: (controllers, url) async {
                      controller.ulrs = url.toString();
                      controller.urlController.text = controller.ulrs;
                    },
                    androidOnPermissionRequest:
                        (controller, origin, resources) async {
                      return PermissionRequestResponse(
                          resources: resources,
                          action: PermissionRequestResponseAction.GRANT);
                    },
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                      var uri = navigationAction.request.url!;
                      if (![
                        "http",
                        "https",
                        "file",
                        "chrome",
                        "data",
                        "javascript",
                        "about"
                      ].contains(uri.scheme)) {
                        // if (await canLaunch(url)) {
                        //   // Launch the App
                        //   await launch(
                        //     url,
                        //   );
                        //   // and cancel the request
                        //   return NavigationActionPolicy.CANCEL;
                        // }
                      }
                      return NavigationActionPolicy.ALLOW;
                    },
                    onLoadStop: (controllers, url) async {
                      controller.pullToRefreshController.endRefreshing();
                      log('ONLOAD : $url');
                      // setState(() {
                      //   this.url = url.toString();
                      //   urlController.text = this.url;
                      //   // print("ON LOAD");
                      //   // print("===============");
                      //   getMetaTags();
                      // });
                    },
                    onLoadError: (controllers, url, code, message) {
                      controller.pullToRefreshController.endRefreshing();
                    },
                    onProgressChanged: (controllers, progress) {
                      if (progress == 100) {
                        controller.pullToRefreshController.endRefreshing();
                      }
                      controller.progress = progress / 100;
                      // controller.urlController.text = url;
                      // setState(() {
                      //   this.progress = progress / 100;
                      //   urlController.text = url;
                      //   log('ON PROGRESS');
                      //   log('===============');
                      //   getMetaTags();
                      // });
                    },
                    onUpdateVisitedHistory:
                        (controllers, url, androidIsReload) {
                      // url = controller.ulrs;
                      // setState(() {
                      //   this.url = url.toString();
                      //   urlController.text = this.url;
                      //   log('UPDATE VISITED HISTORY');
                      //   log('===============');
                      //   getMetaTags();
                      // });
                    },
                    onConsoleMessage: (controller, consoleMessage) {
                      log(consoleMessage.toString());
                    },
                  ),
                  controller.progress < 1.0
                      ? LinearProgressIndicator(value: controller.progress)
                      : Container(),
                ],
              ),
            ),
            // * Card
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  Text(
                    'Preview of visited websites',
                    style: boldNunitoFontStyle.copyWith(
                      color: blackColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Button(
                    text: 'Follow-up',
                    onTap: () {
                      Get.back();
                    },
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
