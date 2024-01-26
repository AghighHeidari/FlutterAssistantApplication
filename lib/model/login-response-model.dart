import 'package:flutter_assistant/model/customer-model.dart';

class LoginRegisterResponseModel {
  Customer? customer;

  LoginRegisterResponseModel({this.customer});

  LoginRegisterResponseModel.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}
