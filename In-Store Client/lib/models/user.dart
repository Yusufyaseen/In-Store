import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String password;
  final String email;
  final String type;
  final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.type,
    required this.token,
  });

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "name": name,
      "password": password,
      "email": email,
      "type": type,
      "token": token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',

    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

}
