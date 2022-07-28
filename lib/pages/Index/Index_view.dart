import 'package:flutter/material.dart';
import 'package:flutter2_template/global.dart';
import 'package:flutter2_template/pages/Index/Index_controller.dart';
import 'package:flutter2_template/pages/home/home_view.dart';
import 'package:flutter2_template/pages/login/login_view.dart';
import 'package:flutter2_template/pages/splash/spalsh_view.dart';
import 'package:get/get.dart';

class IndexPage extends GetView<IndexController> {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: Center(
            child: Text("Index ${controller.isloadWelcomePage}"),
          )
    ));
  }
}
