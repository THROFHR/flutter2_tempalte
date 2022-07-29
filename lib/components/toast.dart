import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../common/values/values.dart';

void toastInfo({
  required String msg,
  Color backgroundColor = Colors.black,
  Color textColor = Colors.white,
}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: 16.sp,
  );
}


void dialogInfo({ String? title,
  String? content, //文本内容
  Widget? contentChild, //文本组件
  Function? cancel,
  String? cancelText,
  Function? confirm,
  String? confirmText,
}) {
  Get.defaultDialog(
    title: title ?? "提示",
    titleStyle: TextStyle(color: AppColors.defaultText),
    titlePadding: EdgeInsets.only(top: 12),
    radius: 12,
    content: ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 500.h,//最大高度
      ),
      child: Container(
        child: SingleChildScrollView(
          child: content != null ? Center(
            child: Text(content, style: TextStyle(color: AppColors.defaultText)),
          ): contentChild,
        ),
      ),
    ),
    barrierDismissible: false, // 点击空白处不能退出
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Text(cancelText ?? "取消", style: TextStyle(color: AppColors.descText)),
            ),
            onTap: (){
              Get.back();
              if(cancel != null) cancel();
            },
          ),
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Text( confirmText ?? "确定", style: TextStyle(color: AppColors.primaryElement)),
            ),
            onTap: (){
              Get.back();
              if(confirm != null) confirm();
            },
          ),
        ],
      ),
    ],
  );
}

void notifyInfo({
  String? title,
  String? content, //文本内容
  Function? confirm,
}){
  Get.snackbar( title ?? "提示", content ?? "", onTap:(snack){
    print(snack);
    if(confirm != null) confirm();
  });
}
