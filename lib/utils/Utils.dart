import 'package:flutter/material.dart';
import 'package:flutter_assistant/utils/icons.dart';
import 'package:flutter_assistant/utils/textEx.dart';
import 'package:get/get.dart';

class Utils {
  static Widget backButton(BuildContext context,
      {Function()? onWillPop, Color? color, double? iconSize}) {
    return InkWell(
      onTap: () {
        if (onWillPop != null) {
          onWillPop();
        }
        Get.back();
      },
      child: Icon(
        IconsEx.arrowRight,
        color: color ?? context.theme.primaryColor,
        size: iconSize ?? 25,
      ),
    );
  }

  static GetSnackBar customSnackBar(
      {required String titleText,
      required String messageText,
      bool success = false}) {
    return GetSnackBar(
      snackPosition: SnackPosition.TOP,
      isDismissible: true,
      duration: const Duration(seconds: 3),
      backgroundColor:
          success ? const Color(0xff34864d) : const Color(0xffe55c5c),
      maxWidth: 400,
      borderRadius: 15,
      animationDuration: const Duration(seconds: 1),
      titleText: Text(
        titleText,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      messageText: Text(
        messageText,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  static Widget customButton(
      {double? width,
      double? height,
      Color? backgroundColor,
      required String text,
      Color? textColor,
      required void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? 200,
        height: height ?? 50,
        decoration: BoxDecoration(
          color: backgroundColor ?? Get.context?.theme.primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

