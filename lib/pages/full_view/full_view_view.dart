import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../router/app_pages.dart';
import 'full_view_logic.dart';

const FullTAG = "fullView";
Widget FullBox({Widget? child, String tag = FullTAG, Function? onTap}){
  return GestureDetector(
    onTap: (){
      onTap!();
    },
    child: Hero(
      tag: tag, //唯一标记，前后两个路由页Hero的tag必须相同
      child: child ?? Container(),
    ),
  );
}

class FullViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logic = Get.find<FullViewLogic>();
    final state = Get.find<FullViewLogic>().state;
    dynamic argumentData = Get.arguments;
    String tag = Get.parameters["tag"] ?? FullTAG;

    return Center(
      child: Hero(
        tag: tag, //
        child: Container(
          width: double.infinity,
          child: Image(
            image: AssetEntityImageProvider(argumentData, isOriginal: false),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );;
  }
}
