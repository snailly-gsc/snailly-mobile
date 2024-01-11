// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snailly/app/data/models/child.dart';
import 'package:snailly/app/data/models/dangerous_website.dart';
import 'package:snailly/app/data/models/global.dart';
import 'package:snailly/app/shared/shared.dart';

import 'package:snailly/app/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class BrowserSurfiorController extends GetxController {
  String search = Get.arguments[0];
  // log(search);
  Child child = Get.arguments[1];
  // log(child.name.toString());
  final _endPoint = "log/";
  final _endPointClassified = "classified-url/dangerous-website/";

  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  late PullToRefreshController pullToRefreshController;
  String urls = "";
  double progress = 0;
  TextEditingController urlController = TextEditingController();
  List<ContentBlocker> blocker = [];

  RxBool isCheckContent = true.obs;

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

  var blacklist_url = [];

  Future postUrl(Uri? url) async {
    if (url == null) return;

    String? keyword = url.toString().split('=').last;
    log("keyword: $keyword");

    final box = GetStorage();
    final data = box.read("dataParent") as Map<String, dynamic>;
    final dataUser = box.read("dataUser") as Map<String, dynamic>;
    String accessToken = data["token"];
    String urlOrigin = url.origin.replaceFirst("www.", "");

    print('urlorigin: $urlOrigin');

    try {
      final response = await http
          .post(Uri.parse(dotenv.get('BASE_URL') + _endPoint), headers: {
        'Authorization': 'Bearer $accessToken'
      }, body: {
        'parentId': dataUser['id'],
        'childId': child.id.toString(),
        'web_title': keyword,
        'web_description': "'",
        'url': urlOrigin,
        'detail_url': url.toString().replaceFirst("www.", ""),
      });
      log(response.body);
      // readData(data['email']);
    } catch (e) {
      Get.snackbar("Gagal", "message");
      log('error: ${e.toString()}');
    }
  }

  String parseURL() {
    bool isValid = Uri.parse(search).isAbsolute;
    urls = search;
    if (isValid) {
      return search;
    } else {
      return "https://google.com/search?q=$search";
    }
  }

  void populateBlackListUrl() {
    blacklist_url.add("xvideos.com");
    blacklist_url.add("xhamster.com");
    blacklist_url.add("redtube.com");
    blacklist_url.add("xnxx.com");
    blacklist_url.add("myfreecams.com");
    blacklist_url.add("youjizz.com");
    blacklist_url.add("youporn.com");
    blacklist_url.add("tube8.com");
    blacklist_url.add("cam4.com");
    blacklist_url.add("playboy.com");
    blacklist_url.add("spankwire.com");
    blacklist_url.add("xtube.com");
    blacklist_url.add("brazzers.com");
    blacklist_url.add("clips4sale.com");
    blacklist_url.add("keezmovies.com");
    blacklist_url.add("drtuber.com");
    blacklist_url.add("extremetube.com");
    blacklist_url.add("slutload.com");
    blacklist_url.add("livejasmin.com");
    blacklist_url.add("freeones.com");
    blacklist_url.add("tubegalore.com");
    blacklist_url.add("fakku.net");
    blacklist_url.add("porntube.com");
    blacklist_url.add("furaffinity.net");
    blacklist_url.add("suicidegirls.com");
    blacklist_url.add("4tube.com");
    blacklist_url.add("adameve.com");
    blacklist_url.add("naughtyamerica.com");
    blacklist_url.add("gaytube.com");
    blacklist_url.add("bangbros.com");
    blacklist_url.add("motherless.com");
    blacklist_url.add("efukt.com");
    blacklist_url.add("alphaporno.com");
    blacklist_url.add("planetsuzy.org");
    blacklist_url.add("ashemaletube.com");
    blacklist_url.add("pornmd.com");
    blacklist_url.add("brazzersnetwork.com");
    blacklist_url.add("tnaflix.com");
    blacklist_url.add("fapdu.com");
    blacklist_url.add("fuq.com");
    blacklist_url.add("x-art.com");
    blacklist_url.add("perfectgirls.net");
    blacklist_url.add("twistys.com");
    blacklist_url.add("men.com");
    blacklist_url.add("porn.com");
    blacklist_url.add("pornoxo.com");
    blacklist_url.add("chaturbate.com");
    blacklist_url.add("apetube.com");
    blacklist_url.add("gonzoxxxmovies.com");
    blacklist_url.add("fleshbot.com");
    blacklist_url.add("nuvid.com");
    blacklist_url.add("badjojo.com");
    blacklist_url.add("sankakucomplex.com");
    blacklist_url.add("camfuze.com");
    blacklist_url.add("cliphunter.com");
    blacklist_url.add("eporner.com");
    blacklist_url.add("slutroulette.com");
    blacklist_url.add("gaymaletube.com");
    blacklist_url.add("gelbooru.com");
    blacklist_url.add("elephanttube.com");
    blacklist_url.add("realitykings.com");
    blacklist_url.add("kindgirls.com");
    blacklist_url.add("boobpedia.com");
    blacklist_url.add("imagefap.com");
    blacklist_url.add("vintage-erotica-forum.com");
    blacklist_url.add("hottystop.com");
    blacklist_url.add("mofos.com");
    blacklist_url.add("youngpornvideos.com");
    blacklist_url.add("pichunter.com");
    blacklist_url.add("zootube365.com");
    blacklist_url.add("freeporn.com");
    blacklist_url.add("wetpussygames.com");
    blacklist_url.add("pornerbros.com");
    blacklist_url.add("femjoy.com");
    blacklist_url.add("dudesnude.com");
    blacklist_url.add("silverdaddies.com");
    blacklist_url.add("swinglifestyle.com");
    blacklist_url.add("givemegay.com");
    blacklist_url.add("homemoviestube.com");
    blacklist_url.add("lobstertube.com");
    blacklist_url.add("tubepleasure.com");
    blacklist_url.add("flirt4free.com");
    blacklist_url.add("pornorama.com");
    blacklist_url.add("voyeurweb.com");
    blacklist_url.add("pornpros.com");
    blacklist_url.add("bravoerotica.com");
    blacklist_url.add("pornrabbit.com");
    blacklist_url.add("digitalplayground.com");
    blacklist_url.add("madthumbs.com");
    blacklist_url.add("orgasm.com");
    blacklist_url.add("boyfriendtv.com");
    blacklist_url.add("sunporno.com");
    blacklist_url.add("gotgayporn.com");
    blacklist_url.add("bravotube.net");
    blacklist_url.add("youporngay.com");
    blacklist_url.add("deviantclip.com");
    blacklist_url.add("naked.com");
    blacklist_url.add("fuskator.com");
    blacklist_url.add("fux.com");
    blacklist_url.add("tubekitty.com");
    blacklist_url.add("rk.com");
    blacklist_url.add("imlive.com");
    blacklist_url.add("theeroticreview.com");
    blacklist_url.add("squirt.org");
    blacklist_url.add("joymii.com");
    blacklist_url.add("watchersweb.com");
    blacklist_url.add("definebabe.com");
    blacklist_url.add("nifty.org");
    blacklist_url.add("entensity.net");
    blacklist_url.add("fling.com");
    blacklist_url.add("hotmovies.com");
    blacklist_url.add("babes.com");
    blacklist_url.add("submityourflicks.com");
    blacklist_url.add("xxxymovies.com");
    blacklist_url.add("4porn.com");
    blacklist_url.add("cams.com");
    blacklist_url.add("youngleafs.com");
    blacklist_url.add("worldsex.com");
    blacklist_url.add("adultwork.com");
    blacklist_url.add("greengaytube.com");
    blacklist_url.add("largeporntube.com");
    blacklist_url.add("hornywhores.net");
    blacklist_url.add("taxidrivermovie.com");
    blacklist_url.add("hot-sex-tube.com");
    blacklist_url.add("scoreland.com");
    blacklist_url.add("aebn.net");
    blacklist_url.add("boysfood.com");
    blacklist_url.add("jjgirls.com");
    blacklist_url.add("eroticbeauties.net");
    blacklist_url.add("fulltubemovies.com");
    blacklist_url.add(
        "www.omgubuntu.co.uk/2021/12/audacity-gives-user-a-xmas-gift-50x-faster-project-loading");
    blacklist_url
        .add("www.omgubuntu.co.uk/2021/12/enlightenment-desktop-0-25-release");
    blacklist_url.add(
        "www.omgubuntu.co.uk/2021/12/libadwaita-1-0-arrives-to-kickstart-a-new-era-of-gtk-app-development");
    blacklist_url.add(
        "outlook.live.com/owa/azis.naufal@gmail.com/startupdata.ashx?app=Opx&n=0");
    blacklist_url.add("www.betclic.com/en/sports-betting/");
    blacklist_url.add("www.pornhub.com/information/terms");
    blacklist_url.add("coinad.media/index.php?page=index/register/2");
    blacklist_url.add("als.dafabet.com/en/sports");
    blacklist_url.add("m.etsy.com");
  }

  // Future<void> getDangerousWebsites(Uri? url) async {
  //   try {
  //     final box = GetStorage();
  //     final dataUser = box.read("dataUser") as Map<String, dynamic>;

  //     var response = await http.get(Uri.parse(
  //       "${dotenv.get('BASE_URL') + _endPointClassified + dataUser["id"]}?domain=${url?.origin}",
  //     ));

  //     if (response.statusCode != 200) {
  //       throw "error1";
  //     }

  //     var data = json.decode(response.body)["data"] as List<dynamic>;
  //     log(data.toString());

  //     List<DangerousWebsite> dangerousWebsites =
  //         DangerousWebsite.fromJsonList(data);

  //     Global.dangerousWebsites = dangerousWebsites;
  //     log("Global.dangerousWebsites: ${Global.dangerousWebsites.length}");
  //   } catch (err) {
  //     log(err.toString());
  //   }
  // }

  Future<void> getDangerousWebsites() async {
    try {
      final box = GetStorage();
      final dataUser = box.read("dataUser") as Map<String, dynamic>;

      var response = await http.get(Uri.parse(
        dotenv.get('BASE_URL') + _endPointClassified + dataUser["id"],
      ));

      if (response.statusCode != 200) {
        throw "error1";
      }

      var data = json.decode(response.body)["data"] as List<dynamic>;
      log(data.toString());

      List<DangerousWebsite> dangerousWebsites =
          DangerousWebsite.fromJsonList(data);

      Global.dangerousWebsites = dangerousWebsites;
      log("Global.dangerousWebsites: ${Global.dangerousWebsites.length}");
    } catch (err) {
      log(err.toString());
    }
  }

  Future checkBlacklist(Uri? url) async {
    if (url == null) return;

    await getDangerousWebsites();
    String urlOrigin = url.origin.replaceFirst("www.", "");

    for (var element in Global.dangerousWebsites) {
      // if (element.url.contains(urlSplit)) {
      if (urlOrigin.contains(element.url)) {
        if (element.grantAccess == true) {
          return;
        }

        if (element.label == 'aman') {
          return;
        }

        final box = GetStorage();
        final data = box.read("dataUser") as Map<String, dynamic>;
        final prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');

        final jwt = JWT({
          "parent": {
            "id": data["id"],
            "nama": data["nama"],
            "email": data["email"],
          },
          "childId": child.id.toString(),
          "web_url": urlOrigin,
          "token": token,
        });

        var dataToken = jwt.sign(SecretKey('snailly'));

        String urlBlock =
            "https://white-pebble-088ad5110.2.azurestaticapps.net?f=$dataToken";
        print("url:$urlBlock");

        webViewController?.loadUrl(
            urlRequest: URLRequest(url: Uri.parse(urlBlock)));
      }
    }

    setTimeOut(() {
      isCheckContent.value = true;
    }, duration: const Duration(milliseconds: 500));
  }

  @override
  void onInit() {
    super.onInit();
    // populateBlackListUrl();
    Global.url = null;
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
}
