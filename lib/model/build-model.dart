class Build {
  int? id;
  int? customerId;
  dynamic requirements;
  String? threadId;
  String? url;
  String? status;

  Build({this.id, this.customerId, this.requirements, this.threadId, this.url, this.status});

  Build.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    requirements = json['requirements'];
    threadId = json['thread_id'];
    url = json['url'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['requirements'] = requirements;
    data['thread_id'] = threadId;
    data['url'] = url;
    data['status'] = status;
    return data;
  }
}