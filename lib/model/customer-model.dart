class Customer {
  int? id;
  String? username;
  String? password;

  Customer({required this.id, required this.username, required this.password});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
