import 'package:flutter2_template/pages/Index/Index_controller.dart';
import 'package:get/get.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<IndexController>(() => IndexController());
    Get.lazyPut(()=>IndexController());
  }
}
