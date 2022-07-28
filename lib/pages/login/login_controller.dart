import 'package:get/get.dart';

import '../../common/api/api.dart';
import '../../common/store/store.dart';
import '../../router/app_pages.dart';

class LoginController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void next() async{
    var userProfile = await UserAPI.login();
    print("=========");
    UserStore.to.saveProfile(userProfile);
    UserStore.to.setToken(userProfile.accessToken ?? '');
    Get.offAllNamed(AppRoutes.Home);
  }
}
