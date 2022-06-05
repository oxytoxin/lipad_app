import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lipad_app/home_page/home_page_controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('LIPAD'),
        ),
        body: controller.loading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("X: ${controller.accelerometerData.value.x.toString()}"),
                    Text("Y: ${controller.accelerometerData.value.y.toString()}"),
                    Text("Heading: ${controller.compassData.value.toString()}"),
                    Text("Reference Heading: ${controller.referenceHeading.value.toString()}"),
                    Text("Heading Difference: ${controller.headingFromReference.toString()}"),
                    ElevatedButton(onPressed: controller.setReference, child: Text('Set Heading Reference')),
                    ElevatedButton(onPressed: controller.sendData, child: Text('Send Data')),
                  ],
                )),
      ),
    ));
  }
}
