import 'dart:convert';

import 'package:get/get.dart';
import '../api/api.dart';
import '../services/services.dart';
import '../values/values.dart';



class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // 是否登录
  final _isLogin = false.obs;
  // 令牌 token
  String token = '';
  // 用户 profile
  final _profile = UserLoginInfoEntity().obs;

  bool get isLogin => _isLogin.value;
  UserLoginInfoEntity get profile => _profile.value;
  bool get hasToken => token.isNotEmpty;



  @override
  void onInit() {
    super.onInit();
    token = StorageService.to.getString(STORAGE_USER_TOKEN_KEY);
    var profileOffline = StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
    if (profileOffline.isNotEmpty) {
      _profile(UserLoginInfoEntity.fromJson(jsonDecode(profileOffline)));
    }
    print("更新登录===============${token}");
    if (token.isNotEmpty) {
      _isLogin.value = true;
    }
  }

  // 保存 token
  Future<void> setToken(String value) async {
    await StorageService.to.setString(STORAGE_USER_TOKEN_KEY, value);
    token = value;
  }

  // 获取 profile
  Future<void> getProfile() async {
    if (token.isEmpty) return;
    var result = await UserAPI.profile();
    _profile(result);
    _isLogin.value = true;
    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(result));
  }

  // 保存 profile
  Future<void> saveProfile(UserLoginInfoEntity profile) async {
    _isLogin.value = true;
    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
    _profile(profile);
  }

  // 保存 profile
  Future<void> updateProfile(Map<String, dynamic> update) async {
    var json = UserStore.to.profile.toJson();
    json["nickname"] = "${DateTime.now()}";
    json.addAll(update);
    var profile = UserLoginInfoEntity.fromJson(json);
    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
    _profile(profile);
  }

  // 注销
  Future<void> onLogout() async {
    if (_isLogin.value) await UserAPI.logout();
    await StorageService.to.remove(STORAGE_USER_TOKEN_KEY);
    _isLogin.value = false;
    token = '';
  }
}
