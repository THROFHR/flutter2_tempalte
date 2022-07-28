import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/values/values.dart';

/// 透明背景 AppBar
AppBar transparentAppBar({
  Widget? title,
  Widget? leading,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: title != null
        ? Center(
            child: title,
          )
        : null,
    leading: leading,
    actions: actions,
  );
}

/// 10像素 Divider
Widget divider10Px({Color bgColor = AppColors.secondaryElement}) {
  return Container(
    height: 10.w,
    decoration: BoxDecoration(
      color: bgColor,
    ),
  );
}


enum AppBarBackType { Back, Close, None }
class BaseScaffold extends Scaffold {
  BaseScaffold(
      {String? title,
      PreferredSizeWidget? appBar,
      required Widget body,
      List<Widget>? actions,
      Widget? floatingActionButton,
      Color? appBarBackgroundColor = AppColors.primaryElement,
      Color? titleColor = AppColors.primaryElementText,
      bool centerTitle = true,
      FloatingActionButtonLocation? floatingActionButtonLocation})
      : super(
          appBar: appBar ?? AppBar(
                actions: actions ?? [],
                centerTitle: centerTitle,
                title: Text(title ?? '', style: TextStyle(color: titleColor ?? Colors.grey[800], fontSize: 18, fontWeight: FontWeight.w500)),
                backgroundColor: appBarBackgroundColor,
              ),
          backgroundColor: Colors.white,
          body: body,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
        );
}
