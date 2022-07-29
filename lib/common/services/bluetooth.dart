import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BlueService {
  static BlueService get to => Get.find();
  late FlutterBluePlus flutterBlue;
  late BluetoothDevice device;
  late Map<String, ScanResult> scanResults;
  late List<BluetoothDevice> allBleNameAry;
  late BluetoothCharacteristic mCharacteristic;

  Future<BlueService> init() async {
    flutterBlue = FlutterBluePlus.instance;
    scanResults = new Map();
    allBleNameAry = [];
    return this;
  }

  void startBle() async {
    // 开始扫描
    flutterBlue.startScan(timeout: Duration(seconds: 4));
    // 监听扫描结果
    flutterBlue.scanResults.listen((results) {
      // 扫描结果 可扫描到的所有蓝牙设备
      for (ScanResult r in results) {
        scanResults[r.device.id.toString()] = r;
        if (r.device.name.length > 0) {
          // print('${r.device.name} found! rssi: ${r.rssi}');
          allBleNameAry.add(r.device);
          getBleScanNameAry();
        }
      }
    });
  }

  List getBleScanNameAry() {
    //更新过滤蓝牙名字
    List distinctIds = allBleNameAry.map((device) => device.id.toString()).toSet().toList();
    List<BluetoothDevice> list = [];
    for(var i = 0; i<distinctIds.length; i++){
      var r = scanResults[distinctIds[i]];
      if(r != null){
        print(r.device);
        list.add(r.device);
      }
    }
    allBleNameAry = list;
    return allBleNameAry;
  }

  // 发送蓝牙连接
  void connectionBle(String id) {
    for (var i = 0; i < allBleNameAry.length; i++) {
      ScanResult? r = scanResults[allBleNameAry[i]];
      if(r != null){
        device = r.device;
        // 停止扫描
        flutterBlue.stopScan();
        discoverServicesBle();
      }
    }
  }

  void discoverServicesBle() async {
    print("连接上蓝牙设备...延迟连接");
    await device
        .connect(autoConnect: false, timeout: Duration(seconds: 10));
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) {
      var value = service.uuid.toString();
      print("所有服务值 --- $value");
      if (service.uuid.toString().toUpperCase().substring(4, 8) == "FFF0") {
        List<BluetoothCharacteristic> characteristics = service.characteristics;
        characteristics.forEach((characteristic) {
          var valuex = characteristic.uuid.toString();
          print("所有特征值 --- $valuex");
          if (characteristic.uuid.toString() ==
              "0000fff1-0000-1000-8000-xxxxxxxx") {
            print("匹配到正确的特征值");
            mCharacteristic = characteristic;

            const timeout = const Duration(seconds: 30);
            Timer(timeout, () {
              dataCallbackBle();
            });
          }
        });
      }
      // do something with service
    });
  }

  dataCallsendBle(List<int> value) {
    mCharacteristic.write(value);
  }

  dataCallbackBle() async {
    await mCharacteristic.setNotifyValue(true);
    mCharacteristic.value.listen((value) {
      // do something with new value
      // print("我是蓝牙返回数据 - $value");
      if (value == null) {
        print("我是蓝牙返回数据 - 空！！");
        return;
      }
      List data = [];
      for (var i = 0; i < value.length; i++) {
        String dataStr = value[i].toRadixString(16);
        if (dataStr.length < 2) {
          dataStr = "0" + dataStr;
        }
        String dataEndStr = "0x" + dataStr;
        data.add(dataEndStr);
      }
      print("我是蓝牙返回数据 - $data");
    });
  }

  void endBle() {
    device.disconnect();
  }
}
