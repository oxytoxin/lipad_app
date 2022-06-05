import 'dart:async';
import 'dart:convert';

import 'package:flutter_compass/flutter_compass.dart';
import 'package:get/get.dart';
import 'package:lipad_app/settings_page/settings_page_controller.dart';
import 'package:sensors_plus/sensors_plus.dart';

class HomePageController extends GetxController {
  var loading = true.obs;
  Rx<AccelerometerEvent> accelerometerData = AccelerometerEvent(0, 0, 0).obs;
  SettingsPageController settingsPageController = Get.find<SettingsPageController>();
  var compassData = 0.obs;
  var referenceHeading = 0.obs;
  // getter function
  int get headingFromReference => (compassData.value - referenceHeading.value) < 0
      ? (compassData.value - referenceHeading.value) + 360
      : (compassData.value - referenceHeading.value);
  @override
  void onInit() {
    super.onInit();
    Stream<AccelerometerEvent> astream = accelerometerEvents;
    accelerometerData.bindStream(astream.map((event) => event));
    FlutterCompass.events?.listen((event) {
      var reading = event.heading!;
      if (reading.round() < 0) {
        compassData.value = 360 - reading.round().abs();
      } else {
        compassData.value = reading.round().abs();
      }
    });
    loading.value = false;
    Timer.periodic(1.seconds, (timer) {
      sendData();
    });
  }

  void sendData() {
    var data = {
      'pitch': accelerometerData.value.x.round(),
      'roll': accelerometerData.value.y.round(),
      'yaw': headingFromReference,
    };
    print('sending');
    settingsPageController.connection.output.add(ascii.encode('${jsonEncode(data)}\n'));
  }

  void setReference() {
    referenceHeading.value = compassData.value;
  }
}
