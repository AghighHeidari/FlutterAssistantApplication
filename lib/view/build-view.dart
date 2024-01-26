import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assistant/controller/creator_controller.dart';
import 'package:flutter_assistant/model/build-model.dart';
import 'package:flutter_assistant/service/pref.dart';
import 'package:flutter_assistant/service/routing/routes.dart';
import 'package:flutter_assistant/utils/build_status.dart';
import 'package:flutter_assistant/utils/icons.dart';
import 'package:flutter_assistant/utils/textEx.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BuildView extends StatefulWidget {
  const BuildView({Key? key}) : super(key: key);

  @override
  _BuildViewState createState() => _BuildViewState();
}

class _BuildViewState extends State<BuildView> {
  late Build? currentBuild;
  CreatorController creatorController = Get.find();
  Pref pref = Get.find();
  late Timer checkTimer;

  @override
  void initState() {
    currentBuild = Get.arguments;
    currentBuild ??= Build(id: 0, status: 'started', url: 'https://test.aghighheidari.ir');
    checkTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      creatorController.checkBuild(
          buildId: currentBuild!.id!,
          callback: (Build? newBuild) {
            if (newBuild != null) {
              setState(() {
                currentBuild = newBuild;
              });
            }
            if (currentBuild?.status == 'finished') {
              timer.cancel();
              pref.setBuild(null);
              Get.offNamed(Routes.result, arguments: currentBuild);
            }
          });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        checkTimer.cancel();
        return true;
      },
      child: SingleChildScrollView(
        child: Container(
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_loadingBoxContainer()],
          ),
        ),
      ),
    );
  }

  Widget _loadingBoxContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Container(
          decoration: BoxDecoration(color: context.theme.backgroundColor, borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: min(Get.width, 400),
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      ' وضعیت:   ${(currentBuild?.status ?? '').convertStatus}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const SizedBox(height: 20,),
                    (currentBuild?.status ?? "") != 'error'
                        ? const SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
