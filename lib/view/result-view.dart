import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assistant/model/build-model.dart';
import 'package:flutter_assistant/utils/icons.dart';
import 'package:flutter_assistant/utils/textEx.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultView extends StatefulWidget {
  const ResultView({Key? key}) : super(key: key);

  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  late Build? currentBuild;

  @override
  void initState() {
    currentBuild = Get.arguments;
    currentBuild ??= Build(id: 0, status: 'سایت ساخته شد!', url: 'https://test.aghighheidari.ir');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_loadingBoxContainer(), _reCreateButton()],
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
                      ' وضعیت:   ${currentBuild?.status ?? ''}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    TextButton(
                        onPressed: () {
                          launchUrl(Uri.parse(currentBuild?.url ?? 'https://test.aghighheidari.ir'));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.theme.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'مشاهده نتیجه',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                                ),
                                SizedBox(width: 20,),
                                Icon(
                                  IconsEx.arrowLeft,
                                  color: Colors.white,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _reCreateButton() {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: context.theme.primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ثبت مجدد',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Icon(
                IconsEx.arrowLeft,
                color: Colors.white,
                size: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

}
