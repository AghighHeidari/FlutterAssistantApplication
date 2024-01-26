import 'package:flutter_assistant/model/build-model.dart';

class CreateResponseModel {
  Build? build;

  CreateResponseModel({this.build});

  CreateResponseModel.fromJson(Map<String, dynamic> json) {
    build = json['build'] != null ? Build.fromJson(json['build']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (build != null) {
      data['build'] = build!.toJson();
    }
    return data;
  }
}