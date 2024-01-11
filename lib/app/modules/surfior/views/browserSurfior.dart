import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BrowserSurfior extends StatefulWidget {
  const BrowserSurfior({Key? key}) : super(key: key);

  @override
  State<BrowserSurfior> createState() => _BrowserSurfiorState();
}

class _BrowserSurfiorState extends State<BrowserSurfior> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: true,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pullToRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(
          color: Colors.blue,
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

  getMetaTags() async {
    List metaTags = [];

    List<Map<dynamic, dynamic>>? metaTagList =
        (await webViewController?.evaluateJavascript(source: """
(function() {
  
var metaTags = [];
var metaTagNodes = document.head.getElementsByTagName('meta');

for (var i = 0; i < metaTagNodes.length; i++) {
  var metaTagNode = metaTagNodes[i];

  var otherAttributes = metaTagNode.getAttributeNames();
  var nameIndex = otherAttributes.indexOf("name");
  if (nameIndex !== -1) otherAttributes.splice(nameIndex, 1);
  var contentIndex = otherAttributes.indexOf("content");
  if (contentIndex !== -1) otherAttributes.splice(contentIndex, 1);

  // var attrs = [];
  // for (var j = 0; j < otherAttributes.length; j++) {
  //   var otherAttribute = otherAttributes[j];
  //   attrs.push(
  //     {
  //       name: otherAttribute,
  //       value: metaTagNode.getAttribute(otherAttribute)
  //     }
  //   );
  // }

  metaTags.push(
    {
      name: metaTagNode.name,
      content: metaTagNode.content,
      attrs: attrs
    }
  );
}
return metaTags;
})();
  """))?.cast<Map<dynamic, dynamic>>();

    if (metaTagList == null) {
      return metaTags;
    }

    for (var metaTag in metaTagList) {
      var attrs = <MetaTagAttribute>[];

      for (var metaTagAttr in metaTag["attrs"]) {
        attrs.add(MetaTagAttribute(
            name: metaTagAttr["name"], value: metaTagAttr["value"]));
      }

      metaTags.add(MetaTag(
          name: metaTag["name"], content: metaTag["content"], attrs: attrs));

      // print(metaTags[0].)
    }

    // print("INI meta tag  ");
    // print("========================");
    // // print(metaTags[5].content);
    // // print(metaTags[7].content);
    // var data = metaTags;
    // print("ini data" + data.toString());

    // print("========================");
    // return metaTags;
  }

  @override
  Widget build(BuildContext context) {
    String search = ModalRoute.of(context)!.settings.arguments.toString();
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

              }

              webViewController?.loadUrl(urlRequest: URLRequest(url: url));
              log('Ini url dan meta tag ${url.toString()}');
              // print('Ini url dan meta tag :' + url.toString());
              // getMetaTags();
            },
          ),
          Expanded(
              child: Stack(
            children: [
              InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(
                    url: Uri.parse("https://www.google.com/search?q=$search")),
                initialOptions: options,
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                  // print("ON WEB VIEW CREATED");
                  // print("===================");
                  // getMetaTags();
                },
                onLoadStart: (controller, url) {
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                    log('URL BARU : ${url.toString()}');
                    log('ON LOAD START');
                    log('==================');
                    getMetaTags();
                  });
                },
                androidOnPermissionRequest:
                    (controller, origin, resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
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
                onLoadStop: (controller, url) async {
                  pullToRefreshController.endRefreshing();
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                    // print("ON LOAD");
                    // print("===============");
                    getMetaTags();
                  });
                },
                onLoadError: (controller, url, code, message) {
                  pullToRefreshController.endRefreshing();
                },
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {
                    pullToRefreshController.endRefreshing();
                  }
                  setState(() {
                    this.progress = progress / 100;
                    urlController.text = url;
                    log('ON PROGRESS');
                    log('===============');
                    getMetaTags();
                  });
                },
                onUpdateVisitedHistory: (controller, url, androidIsReload) {
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                    log('UPDATE VISITED HISTORY');
                    log('===============');
                    getMetaTags();
                  });
                },
                onConsoleMessage: (controller, consoleMessage) {
                  log(consoleMessage.toString());
                },
              ),
              progress < 1.0
                  ? LinearProgressIndicator(value: progress)
                  : Container(),
            ],
          ))
        ],
      )),
    );
  }
}
