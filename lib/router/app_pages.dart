import 'package:flutter/material.dart';
import 'package:flutter2_template/pages/Index/Index_view.dart';
import 'package:flutter2_template/pages/Index/index_binding.dart';
import 'package:flutter2_template/pages/home/home.binding.dart';
import 'package:flutter2_template/pages/home/home_view.dart';
import 'package:flutter2_template/pages/login/login_binding.dart';
import 'package:flutter2_template/pages/login/login_view.dart';
import 'package:flutter2_template/pages/notfound/notfound_view.dart';
import 'package:flutter2_template/pages/proxy/proxy_view.dart';
import 'package:flutter2_template/pages/welcome/welcome_binding.dart';
import 'package:flutter2_template/pages/welcome/welcome_view.dart';
import 'package:get/get.dart';
import '../pages/splash/spalsh_view.dart';

import 'middlewares/middlewares.dart';
import 'observers.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final routes = [
    // 启动页
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => SplashPage(),
    ),
    // 首次欢迎页
    GetPage(
      name: AppRoutes.Welcome,
      page: () => WelcomePage(),
      binding: WelcomeBinding(),
      middlewares: [
        RouteWelcomeMiddleware(priority: 1),
      ],
    ),
    // 注册页
    GetPage(
      name: AppRoutes.Login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.Index,
      page: () => IndexPage(),
      binding: IndexBinding(),
    ),
    GetPage(
      name: AppRoutes.Home,
      page: () => HomePage(),
      binding: HomeBinding(),
      middlewares: [
        RouteAuthMiddleware(priority: 0),
      ],
    ),
    proxyRoute,
  ];

  static final unknownRoute = GetPage(
    name: AppRoutes.NotFound,
    page: () => NotFoundPage(),
  );

  static final proxyRoute = GetPage(
    name: AppRoutes.Proxy,
    page: () => ProxyPage(),
  );


  static navigationTo(String? routeName, Map<String, String>? parameters) {
    if(routeName == null) return;
    Get.toNamed(routeName, parameters: parameters);
  }
  static navigationToCmd(uri) {

  }
}
