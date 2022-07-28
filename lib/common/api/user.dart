import './user_entity.dart';

import '../../utils/utils.dart';



/// 用户
class UserAPI {
  /// 登录
  static Future<UserLoginInfoEntity> login({
    UserLoginRequestEntity? params,
  }) async {
    // var response = await HttpUtil().post(
    //   '/user/login',
    //   data: params?.toJson(),
    // );
    // return UserLoginResponseEntity.fromJson(response);
    await Future.delayed(Duration(seconds: 1));
    return UserLoginInfoEntity.fromJson({ "access_token": "access_token", "display_name": "Example" });
  }

  /// 注册
  static Future<UserLoginInfoEntity> register({
    UserRegisterRequestEntity? params,
  }) async {
    var response = await Request().post(
      '/user/register',
      data: params?.toJson(),
    );
    return UserLoginInfoEntity.fromJson(response);
  }

  /// Profile
  static Future<UserLoginInfoEntity> profile() async {
    // var response = await HttpUtil().post(
    //   '/user/profile',
    // );
    // return UserLoginInfoEntity.fromJson(response);
    await Future.delayed(Duration(seconds: 1));
    return UserLoginInfoEntity.fromJson({ "access_token": "access_token", "display_name": "Example" });
  }

  /// Logout
  static Future logout() async {
    return await Request().post(
      '/user/logout',
    );
  }
}
