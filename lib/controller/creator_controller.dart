import 'package:flutter/material.dart';
import 'package:flutter_assistant/model/build-model.dart';
import 'package:flutter_assistant/model/create-response-model.dart';
import 'package:flutter_assistant/model/login-response-model.dart';
import 'package:flutter_assistant/service/api.dart';
import 'package:flutter_assistant/service/pref.dart';
import 'package:flutter_assistant/utils/Utils.dart';
import 'package:get/get.dart';
import '../service/routing/routes.dart';

class CreatorController extends GetxController with StateMixin<dynamic> {
  final Api api;
  final Pref pref;

  final loginFormKey = GlobalKey<FormState>();

  CreatorController({required this.api, required this.pref});

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

  void create({required dynamic requirements, Function()? callback}) {
    api.create(requirements: requirements).then((value) {
      if (callback != null) {
        callback();
      }
      if (value is CreateResponseModel) {
        pref.setBuild(value.build!);
        Get.toNamed(Routes.build, arguments: value.build!);
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

  void checkBuild({required int buildId, Function(Build? build)? callback}) {
    api.checkBuild(buildId: buildId).then((value) {
      if (value is CreateResponseModel) {
        pref.setBuild(value.build!);
        if (callback != null) {
          callback(value.build);
        }
      }
    }, onError: (err) {
      if (callback != null) {
        callback(null);
      }
      if (err is ApiError) {
        Get.showSnackbar(Utils.customSnackBar(
          titleText: 'خطا',
          messageText: err.message,
        ));
      }
    });
  }
}
