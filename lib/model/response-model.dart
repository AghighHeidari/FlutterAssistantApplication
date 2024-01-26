class ResponseModel {
  dynamic data;
  bool? success;
  String? error;
  String? error_message;

  ResponseModel({body, status, error, error_message});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    success = json['success'];
    error = json['error'];
    error_message = json['error_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data2 = <String, dynamic>{};
    data2['data'] = data;
    data2['success'] = success;
    data2['error'] = error;
    data2['error_message'] = error_message;
    return data2;
  }
}
