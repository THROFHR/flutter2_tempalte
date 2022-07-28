// 注册请求
class UserRegisterRequestEntity {
  String username;
  String password;

  UserRegisterRequestEntity({
    required this.username,
    required this.password,
  });

  factory UserRegisterRequestEntity.fromJson(Map<String, dynamic> json) =>
      UserRegisterRequestEntity(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };
}

// 登录请求
class UserLoginRequestEntity {
  String username;
  String password;

  UserLoginRequestEntity({
    required this.username,
    required this.password,
  });

  factory UserLoginRequestEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginRequestEntity(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
    "email": username,
    "password": password,
  };
}

// 本地存储的用户信息
class UserLoginInfoEntity {
  String? accessToken;
  String? displayName;

  UserLoginInfoEntity({
    this.accessToken,
    this.displayName,
  });

  factory UserLoginInfoEntity.fromJson(Map<String, dynamic> json) =>
      UserLoginInfoEntity(
        accessToken: json["access_token"],
        displayName: json["display_name"],
      );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "display_name": displayName,
  };
}

