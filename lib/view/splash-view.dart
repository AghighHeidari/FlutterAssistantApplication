import 'package:flutter/material.dart';
import 'package:flutter_assistant/service/pref.dart';
import 'package:flutter_assistant/service/routing/routes.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Pref pref = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (pref.isLoggedIn()) {
        Get.toNamed(Routes.home);
      } else {
        Get.toNamed(Routes.login);
      }
    });
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 100,
          height: 200,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SpinKitSpinningLines(
                size: 50,
                color: context.theme.primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
