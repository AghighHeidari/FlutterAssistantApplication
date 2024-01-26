import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_assistant/controller/auth_controller.dart';
import 'package:flutter_assistant/service/assets.dart';
import 'package:flutter_assistant/service/pref.dart';
import 'package:flutter_assistant/service/routing/routes.dart';
import 'package:flutter_assistant/utils/Utils.dart';
import 'package:flutter_assistant/utils/icons.dart';
import 'package:flutter_assistant/utils/textfield.dart';

import '../utils/textEx.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  AuthController authController = Get.find();
  Pref pref = Get.find();
  RxBool loading = false.obs;

  @override
  void initState() {
    super.initState();
    if (pref.isLoggedIn()) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Get.offAllNamed(Routes.home);
      });
    }
    usernameController = TextEditingController(text: '');
    passwordController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Text(
              'دستیار فلاتر',
              style: TextStyle(color: context.theme.primaryColor, fontWeight: FontWeight.bold, fontSize: 36),
            ),
            Image.asset(
              Assets.logo,
              width: 200,
              height: 200,
            ),
            _loginBoxContainer(),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _loginButton(),
                const SizedBox(
                  height: 20,
                ),
                _registerButton(),
              ],
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    ));
  }

  Widget _loginBoxContainer() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Container(
          decoration: BoxDecoration(color: context.theme.backgroundColor, borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            width: min(Get.width, 400),
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'ورود',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                  child: customTextField(textEditingController: usernameController, validator: authController.usernameValidator, hintText: 'نام کاربری', icon: IconsEx.user),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                  child: customTextField(textEditingController: passwordController, validator: authController.passwordValidator, hintText: 'رمز عبور', icon: IconsEx.password, isPassword: true),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _loginButton() {
    return InkWell(
      onTap: () {
        if (usernameController.text.isEmpty) {
          Get.showSnackbar(Utils.customSnackBar(titleText: 'خطا', messageText: 'نام کاربری را وارد کنید', success: false));
          return;
        }
        if (passwordController.text.isEmpty) {
          Get.showSnackbar(Utils.customSnackBar(titleText: 'خطا', messageText: 'رمز عبور را وارد کنید', success: false));
          return;
        }
        loading.value = true;
        context.loaderOverlay.show();
        authController.login(
            username: usernameController.text,
            password: passwordController.text,
            callback: () {
              context.loaderOverlay.hide();
              loading.value = false;
            });
      },
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: context.theme.primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'ورود',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  loading.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(
                          IconsEx.arrowLeft,
                          color: Colors.white,
                          size: 30,
                        )
                ],
              )),
        ),
      ),
    );
  }

  Widget _registerButton() {
    return InkWell(
      onTap: () {
        Get.offAllNamed(Routes.register);
        // loading.value = true;
        // context.loaderOverlay.show();
        // authController.register(
        //     username: usernameController.text,
        //     password: passwordController.text,
        //     callback: () {
        //       context.loaderOverlay.hide();
        //       loading.value = false;
        //     });
      },
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: context.theme.primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'ثبت نام',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  loading.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(
                          IconsEx.arrowLeft,
                          color: Colors.white,
                          size: 30,
                        )
                ],
              )),
        ),
      ),
    );
  }
}
