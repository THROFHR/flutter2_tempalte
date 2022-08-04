import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter2_template/common/values/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../common/services/services.dart';
import '../../components/components.dart';
import '../../pages/home/home_controller.dart';
import '../../utils/utils.dart';

import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DeepLink(
        child: BaseScaffold(
        title: '首页',
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Center(child: Text(controller.count.toString()))),
              TextButton(
                  onPressed: () => controller.increment(),
                  child: Text('count++')),
              GetBuilder<HomeController>(builder: (_) {
                return Text(controller.userName);
              }),
              TextButton(
                  onPressed: () => controller.changeUserName(),
                  child: Text('changeName')),

              ElevatedButton(
                onPressed: () {
                  PhotoService.to.getFiles(context).then((data) async{
                    if(data.length > 0){
                      final File? originFile = await data[0].originFile; // 原图或者原视频
                      List<File> files = [];
                      files.add(originFile!);
                      Request().uploadFile(files);
                    }
                  });
                },
                child: Text("图片"),
              ),
              Icon(IconFont.icon_liebiao, color: AppColors.primaryElement),
              Icon(IconFont.icon_liebiao1, color: AppColors.primaryElement),
            ],
          ),
        ),
    ));
  }
}
