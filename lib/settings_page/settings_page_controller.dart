import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';

class SettingsPageController extends GetxController {
  var loading = true.obs;
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  RxList<BluetoothDevice> devices = <BluetoothDevice>[].obs;
  late BluetoothConnection connection;
  var connectedDevice = ''.obs;
  @override
  void onInit() async {
    super.onInit();
    await bluetooth.requestDisable();
    await bluetooth.requestEnable();
    await scanDevices();
  }

  Future<void> scanDevices() async {
    loading.value = true;
    await bluetooth.requestEnable();
    await bluetooth.cancelDiscovery();
    bluetooth.startDiscovery().listen((event) {
      if (!devices.contains(event.device)) {
        devices.add(event.device);
      }
    });
    loading.value = false;
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    loading.value = true;
    connection = await BluetoothConnection.toAddress(device.address);
    if (connection.isConnected) {
      Get.snackbar('Success', 'Connected to ${device.name}');
      devices.removeWhere((element) => element.address == device.address);
      connectedDevice.value = device.name ?? 'Unknown';
    } else {
      Get.snackbar('Error', 'Failed to connect to ${device.name}');
    }
    loading.value = false;
  }
}
