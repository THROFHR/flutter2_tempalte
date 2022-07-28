import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter2_template/global.dart';
import 'package:flutter2_template/router/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'common/values/values.dart';


void main() async {
  await Global.init();
  if(SENTRY_SERVER_API_URL.isNotEmpty) {
    await SentryFlutter.init(
          (options) => options.dsn = SENTRY_SERVER_API_URL,
      appRunner: () => runApp(MyApp()),
    );
  } else {
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => RefreshConfiguration(
        headerBuilder: () => ClassicHeader(),
        footerBuilder: () => ClassicFooter(),
        hideFooterWhenNotFull: true,
        headerTriggerDistance: 80,
        maxOverScrollExtent: 100,
        footerTriggerDistance: 150,
        child: GetMaterialApp(
          title: 'App Name',
          // theme: AppTheme.light,
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          builder: EasyLoading.init(),
          defaultTransition: GetPlatform.isIOS ? Transition.native : Transition.rightToLeft, //动画
          navigatorObservers: [AppPages.observer],
          enableLog: true,
          unknownRoute: AppPages.unknownRoute,
        ),
    ));
  }
}
