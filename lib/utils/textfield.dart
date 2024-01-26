import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

Widget customTextField(
    {required TextEditingController textEditingController,
    String? Function(String?)? validator,
    String hintText = '',
    IconData? icon,
    bool isNumeric = false,
    bool isPassword = false}) {
  RxBool passwordVisible = false.obs;
  return Obx(() => TextFormField(
        controller: textEditingController,
        validator: validator,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        obscureText: !passwordVisible.value && isPassword,
        style: const TextStyle(color: Colors.black, fontSize: 16),
        decoration: InputDecoration(
            suffix: isPassword
                ? InkWell(
                    onTap: () {
                      passwordVisible.value = !passwordVisible.value;
                    },
                    child: Icon(isPassword && passwordVisible.value
                        ? Iconsax.eye
                        : Iconsax.eye_slash),
                  )
                : null,
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(right: 15, left: 15),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            disabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            errorBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            focusedErrorBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            icon: icon != null
                ? Icon(
                    icon,
                    size: 30,
                    color: Colors.white,
                  )
                : null),
      ));
}
