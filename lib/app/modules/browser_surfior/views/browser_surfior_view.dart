import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';
import 'package:snailly/app/shared/shared.dart';

import '../controllers/browser_surfior_controller.dart';

class BrowserSurfiorView extends GetView<BrowserSurfiorController> {
  const BrowserSurfiorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
              ),
              // controller: search != null ? "" : urlController,
              keyboardType: TextInputType.url,
              onSubmitted: (value) {
                var url = Uri.parse(value);
                if (url.scheme.isEmpty) {
                  url = Uri.parse("https://www.google.com/search?q=$value");
                  // getMetaTags();
                  log("Url");
                }

                controller.webViewController
                    ?.loadUrl(urlRequest: URLRequest(url: url));
                log('Ini url dan meta tag ${url.toString()}');
                // print('Ini url dan meta tag :' + url.toString());
                // getMetaTags();
              },
            ),
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
                      // print("ON WEB VIEW CREATED");
                      // print("===================");
                      log(controller.search);
                      log(controller.child.name.toString());
                      log(controller.urls);
                      // getMetaTags();
                    },
                    onLoadStart: (controllers, url) async {
                      log('ONLOAD START : $url');

                      controller.isCheckContent.value = false;
                      controller.urls = url.toString();
                      controller.urlController.text = controller.urls;

                      if (!url.toString().contains(
                          'https://white-pebble-088ad5110.2.azurestaticapps.net')) {
                        log('ONLOAD CHECK');
                        await controller.postUrl(url);
                        controller.checkBlacklist(url);
                      } else {
                        setTimeOut(() {
                          controller.isCheckContent.value = true;
                        }, duration: const Duration(milliseconds: 500));
                      }
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
                      log('ONLOAD STOP : $url');
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
                  // controller.progress < 1.0
                  //     ? LinearProgressIndicator(value: controller.progress)
                  //     : Container(),
                  Obx(
                    () => Visibility(
                      visible: controller.isCheckContent.value == false
                          ? true
                          : false,
                      child: Container(
                        color: whiteColor,
                        child: makeLoadingIndicator(),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
