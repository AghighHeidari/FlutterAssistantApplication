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

extension CustomInt on int {
  get convertGrade {
    switch (this) {
      case 10:
        return 'دهم';
      case 11:
        return 'یازدهم';
      case 12:
        return 'دوازدهم';
      default:
        return 'نامشخص';
    }
  }

  get convertField {
    switch (this) {
      case 3:
        return 'ریاضی‌فیزیک';
      case 2:
        return 'علوم تجربی';
      case 1:
        return 'علوم انسانی';
      default:
        return 'نامشخص';
    }
  }

  get convertLesson {
    switch (this) {
      case 1:
        return 'ادبیات فارسی';
      case 2:
        return 'عربی عمومی';
      case 3:
        return 'دینی';
      case 4:
        return 'زبان انگلیسی';
      case 5:
        return 'ریاضی';
      case 6:
        return 'اقتصاد';
      case 7:
        return 'علوم و فنون';
      case 8:
        return 'جامعه شناسی';
      case 9:
        return 'عربی اختصاصی';
      case 10:
        return 'تاریخ';
      case 11:
        return 'جغرافیا';
      case 12:
        return 'منطق';
      default:
        return 'نامشخص';
    }
  }
}

extension CustomString on String {
  get convertField {
    switch (this) {
      case 'mathematics':
        return 'ریاضی‌فیزیک';
      case 'experimental_sciences':
        return 'علوم تجربی';
      case 'liberal_arts':
        return 'علوم انسانی';
      case '3':
        return 'ریاضی‌فیزیک';
      case '2':
        return 'علوم تجربی';
      case '1':
        return 'علوم انسانی';
      default:
        return 'نامشخص';
    }
  }

  get convertGrade {
    switch (this) {
      case '10':
        return 'دهم';
      case '11':
        return 'یازدهم';
      case '12':
        return 'دوازدهم';
      default:
        return 'نامشخص';
    }
  }

  get convertLesson {
    String value = this;
    value = value.split("C").first;
    value = value.substring(0, value.length - 1);
    switch (value) {
      case "G10_F1_L1":
        return 'ادبیات فارسی';
      case "G10_F1_L2":
        return 'عربی عمومی';
      case "G10_F1_L3":
        return 'دینی';
      case "G10_F1_L4":
        return 'زبان انگلیسی';
      case "G10_F1_L5":
        return 'ریاضی';
      case "G10_F1_L6":
        return 'اقتصاد';
      case "G10_F1_L7":
        return 'علوم و فنون';
      case "G10_F1_L8":
        return 'جامعه شناسی';
      case "G10_F1_L9":
        return 'عربی اختصاصی';
      case "G10_F1_L10":
        return 'تاریخ';
      case "G10_F1_L11":
        return 'جغرافیا';
      case "G10_F1_L12":
        return 'منطق';
      case "G11_F1_L1":
        return 'ادبیات فارسی';
      case "G11_F1_L2":
        return 'عربی عمومی';
      case "G11_F1_L3":
        return 'دینی';
      case "G11_F1_L4":
        return 'زبان انگلیسی';
      case "G11_F1_L5":
        return 'ریاضی';
      case "G11_F1_L6":
        return 'علوم و فنون';
      case "G11_F1_L7":
        return 'جامعه شناسی';
      case "G11_F1_L8":
        return 'عربی اختصاصی';
      case "G11_F1_L9":
        return 'تاریخ';
      case "G11_F1_L10":
        return 'جغرافیا';
      case "G11_F1_L11":
        return 'فلسفه';
      case "G11_F1_L12":
        return 'روانشناسی';
      case "G12_F1_L1":
        return 'ادبیات فارسی';
      case "G12_F1_L2":
        return 'عربی عمومی';
      case "G12_F1_L3":
        return 'دینی';
      case "G12_F1_L4":
        return 'زبان انگلیسی';
      case "G12_F1_L5":
        return 'ریاضی';
      case "G12_F1_L6":
        return 'علوم و فنون';
      case "G12_F1_L7":
        return 'جامعه شناسی';
      case "G12_F1_L8":
        return 'عربی اختصاصی';
      case "G12_F1_L9":
        return 'تاریخ';
      case "G12_F1_L10":
        return 'جغرافیا';
      case "G12_F1_L11":
        return 'فلسفه';
      default:
        return 'نامشخص';
    }
  }

  get convertHardness {
    switch (this) {
      case 'all':
        return 'ترکیبی';
      case 'easy':
        return 'آسان';
      case 'medium':
        return 'متوسط';
      case 'hard':
        return 'سخت';
      case 'آسان':
        return 'easy';
      case 'متوسط':
        return 'medium';
      case 'سخت':
        return 'hard';
      case 'ترکیبی':
        return 'all';
      default:
        return 'نامشخص';
    }
  }

  get fixMath {}
}

extension RestTimeOnDuration on Duration {
  int get inDaysRest => inDays;

  int get inHoursRest => inHours - (inDays * 24);

  int get inMinutesRest => inMinutes - (inHours * 60);

  int get inSecondsRest => inSeconds - (inMinutes * 60);

  int get inMillisecondsRest => inMilliseconds - (inSeconds * 1000);

  int get inMicrosecondsRest => inMicroseconds - (inMilliseconds * 1000);
}
