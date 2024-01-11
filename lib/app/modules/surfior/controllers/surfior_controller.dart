import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:snailly/app/data/models/child.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SurfiorController extends GetxController {
  TextEditingController searchController = TextEditingController();
  Child child = Get.arguments as Child;

  final SpeechToText speech = SpeechToText();
  var isListening = false.obs;

  void listen() async {
    if (isListening.value) {
      bool available = await speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        speech.listen(
          onResult: (val) {
            searchController.text = val.recognizedWords;
          },
        );
      }
    } else {
      speech.stop();
    }
  }
}
