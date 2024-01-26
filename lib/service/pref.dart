import 'dart:convert';

import 'package:flutter_assistant/model/build-model.dart';
import 'package:flutter_assistant/model/customer-model.dart';
import 'package:flutter_assistant/service/routing/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Pref {
  static final box = () => GetStorage();

  // User Info

  var customer = ''.val(PrefKey.customer.name, getBox: box);
  var build = ''.val(PrefKey.build.name, getBox: box);
  var url = 'https://api.aghighheidari.ir'.val(PrefKey.url.name, getBox: box);

  bool isLoggedIn() {
    return getCustomer() != null;
  }

  Customer? getCustomer() {
    if (customer.val.isNotEmpty) {
      return Customer.fromJson(jsonDecode(customer.val));
    } else {
      return null;
    }
  }

  void setCustomer(Customer? customer) {
    if (customer == null) {
      this.customer.val = '';
      return;
    }
    this.customer.val = jsonEncode(customer.toJson());
  }

  Build? getBuild() {
    if (build.val.isNotEmpty) {
      return Build.fromJson(jsonDecode(build.val));
    } else {
      return null;
    }
  }

  void setBuild(Build? build) {
    if (build == null) {
      this.build.val = '';
      return;
    }
    this.build.val = jsonEncode(build.toJson());
  }

  void logOut() {
    customer.val = '';
    Get.offAllNamed(Routes.splash);
  }
}

enum PrefKey { customer, build, url }
