import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

Widget loadingWidget(BuildContext context) {
  return BackdropFilter(
    filter: ImageFilter.blur(
      sigmaX: 3,
      sigmaY: 3,
    ),
    child: Center(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SpinKitCubeGrid(
            size: 100,
            color: context.theme.primaryColor,
          )),
    ),
  );
}
