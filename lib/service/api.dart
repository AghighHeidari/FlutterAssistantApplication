import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_assistant/model/create-response-model.dart';
import 'package:flutter_assistant/model/login-response-model.dart';
import 'package:flutter_assistant/model/response-model.dart';
import 'package:get/get.dart';
import 'pref.dart';

class Api extends GetConnect {
  Pref pref = Get.find();

  @override
  void onInit() {
    httpClient.baseUrl = pref.url.val;
    httpClient.defaultContentType = "application/json";
    httpClient.timeout = const Duration(seconds: 60);
    httpClient.defaultDecoder = (obj) {
      try {
        return ResponseModel.fromJson(jsonDecode(obj));
      } catch (e) {
        try {
          return ResponseModel.fromJson(obj);
        } catch (e) {
          return obj;
        }
      }
    };
    super.onInit();
  }

  Future<dynamic> login({required String username, required String password}) async {
    var body = {'username': username, 'password': password};
    return responseParser(await post('/auth/login', body, headers: {'language': 'fa'}), (map) => LoginRegisterResponseModel.fromJson(map), showLog: true);
  }

  Future<dynamic> register({required String username, required String password}) async {
    var body = {'username': username, 'password': password};
    return responseParser(await post('/auth/register', body, headers: {'language': 'fa'}), (map) => LoginRegisterResponseModel.fromJson(map), showLog: true);
  }

  Future<dynamic> create({required dynamic requirements}) async {
    var body = {'user_id': Pref().getCustomer()!.id, 'requirements': requirements};
    return responseParser(await post('/openai/create', body, headers: {'language': 'fa'}), (map) => CreateResponseModel.fromJson(map), showLog: true);
  }

  Future<dynamic> responseParser(
    Response response,
    Function(dynamic map) decode, {
    bool showLog = false,
  }) {
    try {
      if (kDebugMode) {
        print(response.request?.url.toString());
        if (showLog) {
          print(response.bodyString);
        }
      }
    } catch (_) {}
    if (!response.body?.success) {
      return Future.error(ApiError(response.body!.error_message!, 200));
    } else {
      if (response.body.data == null) {
        return Future.value(decode.call(<String, dynamic>{}));
      }
      return Future.value(decode.call(response.body.data));
    }
  }

  String objectToString(Object object) {
    Map jsonMapped = json.decode(json.encode(object));
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String prettyPrint = encoder.convert(jsonMapped);
    return prettyPrint;
  }
}

class ApiError {
  final String message;
  final int code;

  ApiError(this.message, this.code);
}
