import 'package:flutter_assistant/view/build-view.dart';
import 'package:flutter_assistant/view/home-view.dart';
import 'package:flutter_assistant/view/login-view.dart';
import 'package:flutter_assistant/view/register-view.dart';
import 'package:flutter_assistant/view/result-view.dart';
import 'package:flutter_assistant/view/splash-view.dart';
import 'package:get/get.dart';
import 'routes.dart';

class Router {
  static final routes = [
    GetPage(name: Routes.splash, page: () => const SplashView()),
    GetPage(name: Routes.home, page: () => const HomeView()),
    GetPage(name: Routes.login, page: () => const LoginView()),
    GetPage(name: Routes.register, page: () => const RegisterView()),
    GetPage(name: Routes.build, page: () => const BuildView()),
    GetPage(name: Routes.result, page: () => const ResultView()),
  ];
}
