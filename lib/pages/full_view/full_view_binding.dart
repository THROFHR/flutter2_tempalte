import 'package:get/get.dart';

import 'full_view_logic.dart';

class FullViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FullViewLogic());
  }
}
