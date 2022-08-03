import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import "dart:typed_data";

const String _ALPHABET = "0123456789abcdef";


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

  List<int> encoder(String hex) {
    String str = hex.replaceAll(" ", "");
    str = str.toLowerCase();
    if(str.length % 2 != 0) {
      str = "0" + str;
    }
    Uint8List result = new Uint8List(str.length ~/ 2);
    for(int i = 0 ; i < result.length ; i++) {
      int firstDigit = _ALPHABET.indexOf(str[i*2]);
      int secondDigit = _ALPHABET.indexOf(str[i*2+1]);
      if (firstDigit == -1 || secondDigit == -1) {
        throw new FormatException("Non-hex character detected in $hex");
      }
      result[i] = (firstDigit << 4) + secondDigit;
    }
    return result;
  }
  String decoder(List<int> bytes) {
    StringBuffer buffer = new StringBuffer();
    for (int part in bytes) {
      if (part & 0xff != part) {
        throw new FormatException("Non-byte integer detected");
      }
      buffer.write('${part < 16 ? '0' : ''}${part.toRadixString(16)}');
    }
    return buffer.toString();
  }

  // 发送数据
  dataCallsendBle(String data) {
    List<int> value = encoder(data);
    mCharacteristic.write(value);
  }

  // 接收数据
  dataCallbackBle() async {
    await mCharacteristic.setNotifyValue(true);
    mCharacteristic.value.listen((value) {
      // do something with new value
      var data = decoder(value);
      print("我是蓝牙返回数据 - $data");
    });
  }

  void endBle() {
    device.disconnect();
  }
}
