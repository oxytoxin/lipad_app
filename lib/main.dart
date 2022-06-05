import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lipad_app/home_page/home_page.dart';
import 'package:lipad_app/home_page/home_page_controller.dart';
import 'package:lipad_app/settings_page/settings_page.dart';
import 'package:lipad_app/settings_page/settings_page_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return GetMaterialApp(
      title: 'LIPAD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/settings',
      getPages: [
        GetPage(
            name: '/settings',
            page: () => SettingsPage(),
            binding: BindingsBuilder.put(
              () => SettingsPageController(),
            )),
        GetPage(
            name: '/homepage',
            page: () => HomePage(),
            binding: BindingsBuilder.put(
              () => HomePageController(),
            )),
      ],
    );
  }
}
