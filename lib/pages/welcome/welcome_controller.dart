import 'package:flutter2_template/router/app_pages.dart';
import 'package:get/get.dart';

import '../../common/store/config.dart';

class WelcomeController extends GetxController {

    @override
    void onInit() {
    super.onInit();
    }

    @override
    void onReady() {}

    @override
    void onClose() {}

    void next() async{
        await ConfigStore.to.saveAlreadyOpen();
        Get.offAndToNamed(AppRoutes.Login);
    }
}
