import 'package:flutter/material.dart';
import 'package:flutter2_template/router/app_pages.dart';
import 'package:get/get.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("路由没有找到"),
      ),
      body: ListTile(
        title: Text("返回首页"),
        subtitle: Text('返回首页'),
        onTap: () => Get.offAllNamed(AppRoutes.Home),
      ),
    );
  }
}
