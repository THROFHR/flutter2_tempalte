import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class PhotoService extends GetxService {
  static PhotoService get to => Get.find();


  Future<PhotoService> init() async {
    return this;
  }

  // 拍照、录像
  Future<AssetEntity?> camera(BuildContext context, {
    Duration? maximumRecordingDuration = const Duration(seconds: 15),
    RequestType requestType = RequestType.common, //图片+视频
  }) async {
    var pickerConfig = CameraPickerConfig(
      enableRecording: requestType == RequestType.common || requestType == RequestType.video,
      onlyEnableRecording: requestType == RequestType.video,
      maximumRecordingDuration: maximumRecordingDuration,
    );

    final AssetEntity? file = await CameraPicker.pickFromCamera(
      context,
      pickerConfig: pickerConfig,
    );
    return file;
  }


  // 获取图片、视频
  Future<List<AssetEntity>> getFiles(BuildContext context, {
    int maxAssets = 1,
    RequestType requestType = RequestType.common, //图片+视频
  }) async {
    final PermissionState _ps = await PhotoManager.requestPermissionExtend();
    if (_ps.isAuth) {
      // requestType: RequestType.image,
      final List<AssetEntity>? result = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          maxAssets: maxAssets,
          requestType: requestType,
        ),
      );
      return result ?? [];
    }
    EasyLoading.showError('没有权限打开相机');
    PhotoManager.openSetting();
    return [];
  }
}
