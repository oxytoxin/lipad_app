import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lipad_app/settings_page/settings_page_controller.dart';

class SettingsPage extends GetView<SettingsPageController> {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        floatingActionButton:
            FloatingActionButton(onPressed: controller.scanDevices, child: const Icon(Icons.bluetooth)),
        body: controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    controller.connectedDevice.value == ''
                        ? Container()
                        : Text('Connected to ${controller.connectedDevice.value}'),
                    ElevatedButton(
                        onPressed: () {
                          Get.toNamed('/homepage');
                        },
                        child: Text('Go to Main Page')),
                    Expanded(
                      child: ListView.builder(
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(controller.devices[index].name ?? 'Unknown'),
                              subtitle: Text(controller.devices[index].address),
                              onTap: () {
                                controller.connectToDevice(controller.devices[index]);
                              },
                            );
                          },
                          itemCount: controller.devices.length),
                    ),
                  ],
                ),
              ),
      ),
    ));
  }
}
