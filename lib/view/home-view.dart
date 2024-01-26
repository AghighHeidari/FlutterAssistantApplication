import 'dart:math';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_assistant/controller/creator_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  AuthController authController = Get.find();
  CreatorController creatorController = Get.find();
  Pref pref = Get.find();
  RxBool loading = false.obs;
  late TextEditingController titleController;
  late TextEditingController productTypeController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;
  late TextEditingController instagramController;
  late TextEditingController telegramController;
  late TextEditingController menuItemController;
  late TextEditingController productTitleController;
  late TextEditingController productPriceController;
  late Color primaryColor;
  late Color secondaryColor;
  late Color tertiaryColor;
  late List<String> menuItems;
  late List<dynamic> products;
  late String shopType;
  late List<String> shopTypes = ['آنلاین', 'حضوری', 'آنلاین و حضوری'];

  @override
  void initState() {
    super.initState();
    if (Pref().getBuild() != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Get.toNamed(Routes.build, arguments: Pref().getBuild()!);
      });
    }
    titleController = TextEditingController(text: '');
    productTypeController = TextEditingController(text: '');
    phoneNumberController = TextEditingController(text: '');
    emailController = TextEditingController(text: '');
    instagramController = TextEditingController(text: '');
    telegramController = TextEditingController(text: '');
    menuItemController = TextEditingController(text: '');
    productTitleController = TextEditingController(text: '');
    productPriceController = TextEditingController(text: '');
    primaryColor = Colors.red;
    secondaryColor = Colors.redAccent;
    tertiaryColor = Colors.blueGrey;
    menuItems = [];
    products = [];
    shopType = 'آنلاین';
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
              'فرم درخواست',
              style: TextStyle(color: context.theme.primaryColor, fontWeight: FontWeight.bold, fontSize: 36),
            ),
            Image.asset(
              Assets.logo,
              width: 200,
              height: 200,
            ),
            _creatorBoxContainer(),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _createButton(),
                const SizedBox(
                  height: 20,
                ),
                _logoutButton(),
              ],
            ),
            const SizedBox(height: 50,)
          ],
        ),
      ),
    ));
  }

  Widget _creatorBoxContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Container(
          decoration: BoxDecoration(color: context.theme.backgroundColor, borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            width: min(Get.width, 400),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    child: customTextField(textEditingController: titleController, hintText: 'عنوان فروشگاه *', icon: IconsEx.documentText),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    child: customTextField(textEditingController: productTypeController, hintText: 'نوع محصولات *', icon: Icons.question_mark),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    child: customTextField(textEditingController: phoneNumberController, hintText: 'شماره تماس', icon: IconsEx.call),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    child: customTextField(textEditingController: emailController, hintText: 'ایمیل', icon: IconsEx.emailSign),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    child: customTextField(textEditingController: instagramController, hintText: 'آیدی ابنستاگرام', icon: FontAwesomeIcons.instagram),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    child: customTextField(textEditingController: telegramController, hintText: 'آیدی تلگرام', icon: FontAwesomeIcons.telegram),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 30,
                          child: Icon(
                            IconsEx.shop,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          width: 285,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              hintText: 'نوع فروشگاه',
                              hintStyle: const TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                              contentPadding: const EdgeInsets.only(right: 15, left: 15),
                              // prefixIcon: const Icon(IconsEx.shop),
                            ),
                            dropdownColor: Colors.white,
                            focusColor: Colors.white,
                            value: shopType,
                            onChanged: (String? newValue) {
                              setState(() {
                                shopType = newValue!;
                              });
                            },
                            items: shopTypes.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 30,
                          child: Icon(
                            FontAwesomeIcons.palette,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            await ColorPicker(onColorChanged: (Color value) {
                              setState(() {
                                primaryColor = value;
                              });
                            }).showPickerDialog(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: primaryColor,
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            width: 30,
                            height: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            await ColorPicker(onColorChanged: (Color value) {
                              setState(() {
                                secondaryColor = value;
                              });
                            }).showPickerDialog(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: secondaryColor,
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            width: 30,
                            height: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            await ColorPicker(onColorChanged: (Color value) {
                              setState(() {
                                tertiaryColor = value;
                              });
                            }).showPickerDialog(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: tertiaryColor,
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            width: 30,
                            height: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 270,
                          child: customTextField(textEditingController: menuItemController, hintText: 'آیتم منو *', icon: Icons.list),
                        ),
                        IconButton(
                          onPressed: () {
                            if (menuItemController.text.isEmpty) {
                              Utils.customSnackBar(titleText: 'خطا', messageText: 'لطفا آیتم منو را وارد کنید', success: false).show();
                              return;
                            }
                            setState(() {
                              menuItems.add(menuItemController.text);
                              menuItemController.clear();
                            });
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                              color: context.theme.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: 50,
                            height: 50,
                            child: const Icon(
                              IconsEx.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      Column(
                        children: [
                          ...menuItems.map((e) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      e,
                                      style: const TextStyle(color: Colors.white, fontSize: 18),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          menuItems.remove(e);
                                        });
                                      },
                                      icon: Container(
                                        decoration: BoxDecoration(
                                          color: context.theme.primaryColor,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        width: 50,
                                        height: 50,
                                        child: const Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    child: customTextField(textEditingController: productTitleController, hintText: 'نام محصول *', icon: FontAwesomeIcons.gamepad),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 270,
                          child: customTextField(textEditingController: productPriceController, hintText: 'قیمت محصول *', icon: FontAwesomeIcons.moneyBill, isNumeric: true),
                        ),
                        IconButton(
                          onPressed: () {
                            if (productTitleController.text.isEmpty || productPriceController.text.isEmpty) {
                              Utils.customSnackBar(titleText: 'خطا', messageText: 'لطفا نام و قیمت محصول را وارد کنید', success: false).show();
                              return;
                            }
                            setState(() {
                              products.add({
                                'name': productTitleController.text,
                                'price': productPriceController.text,
                              });
                              productTitleController.clear();
                              productPriceController.clear();
                            });
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                              color: context.theme.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: 50,
                            height: 50,
                            child: const Icon(
                              IconsEx.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 50,
                      ),
                      Column(
                        children: [
                          ...products.map((e) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 230,
                                      child: Text(
                                        '${e['name']}\n${e['price']}',
                                        style: const TextStyle(color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          products.remove(e);
                                        });
                                      },
                                      icon: Container(
                                        decoration: BoxDecoration(
                                          color: context.theme.primaryColor,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        width: 50,
                                        height: 50,
                                        child: const Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget _logoutButton() {
    return InkWell(
      onTap: () {
        authController.logout(callback: () {
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
                    'خروج',
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

  Widget _createButton() {
    return InkWell(
      onTap: () {
        if (titleController.text.isEmpty ||
            productTypeController.text.isEmpty ||
            menuItems.isEmpty ||
            products.isEmpty) {
          Utils.customSnackBar(titleText: 'خطا', messageText: 'لطفا تمامی فیلدهای اجباری را پر کنید', success: false).show();
          return;
        }
        creatorController.create(
            requirements: {
              'title': titleController.text,
              'itemType': productTypeController.text,
              'menuItems': menuItems,
              'colors': [primaryColor.hex, secondaryColor.hex, tertiaryColor.hex],
              'products': products,
              'shopType': shopType,
              'phoneNumber': phoneNumberController.text,
              'email': emailController.text,
              'instagram': instagramController.text,
              'telegram': telegramController.text
            },
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
                    'ایجاد',
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
