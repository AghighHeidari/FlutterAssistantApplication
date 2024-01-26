import 'package:flutter/material.dart';
import 'package:flutter_assistant/model/login-response-model.dart';
import 'package:flutter_assistant/service/api.dart';
import 'package:flutter_assistant/service/pref.dart';
import 'package:flutter_assistant/utils/Utils.dart';
import 'package:get/get.dart';
import '../service/routing/routes.dart';

class AuthController extends GetxController with StateMixin<dynamic> {
  final Api api;
  final Pref pref;

  final loginFormKey = GlobalKey<FormState>();

  AuthController({required this.api, required this.pref});

  @override
  void onInit() {
    change(null, status: RxStatus.empty());
    super.onInit();
  }

  String? usernameValidator(String? value) {
    if (value?.isEmpty == true) {
      return 'نام کاربری نباید خالی باشد.';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value?.isEmpty == true) {
      return 'رمزعبور نباید خالی باشد.';
    } else if ((value ?? '').length < 8) {
      return 'رمزعبور نباید کمتر از 8 کاراکتر باشد.';
    }
    return null;
  }

  void login({required String username, required String password, Function()? callback}) {
    api.login(username: username, password: password).then((value) {
      if (callback != null) {
        callback();
      }
      if (value is LoginRegisterResponseModel) {
        pref.setCustomer(value.customer!);
        Get.offAllNamed(Routes.home);
      }
    }, onError: (err) {
      if (callback != null) {
        callback();
      }
      if (err is ApiError) {
        Get.showSnackbar(Utils.customSnackBar(
          titleText: 'خطا',
          messageText: err.message,
        ));
      }
    });
  }

  void register({required String username, required String password, Function()? callback}) {
    api.register(username: username, password: password).then((value) {
      if (callback != null) {
        callback();
      }
      if (value is LoginRegisterResponseModel) {
        pref.setCustomer(value.customer!);
        Get.offAllNamed(Routes.home);
      }
    }, onError: (err) {
      if (callback != null) {
        callback();
      }
      if (err is ApiError) {
        Get.showSnackbar(Utils.customSnackBar(
          titleText: 'خطا',
          messageText: err.message,
        ));
      }
    });
  }

  void logout({Function()? callback}) {
        pref.setCustomer(null);
        Get.offAllNamed(Routes.splash);
  }
}
