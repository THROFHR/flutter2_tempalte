import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../router/app_pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Get.offAndToNamed(AppRoutes.Welcome);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('这是欢迎页👏, 2s后跳转'),
        ),
      ),
    );
  }
}
