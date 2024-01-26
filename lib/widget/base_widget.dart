import 'package:flutter/material.dart';
import 'package:flutter_assistant/service/pref.dart';
import 'package:get/get.dart';

class BaseWidget extends StatelessWidget {
  final Widget? child;
  final Pref pref = Get.find();

  BaseWidget({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: child!),
          ],
        ),
      ),
    );
  }
}
