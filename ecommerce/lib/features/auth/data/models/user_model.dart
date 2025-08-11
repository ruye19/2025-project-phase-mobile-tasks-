import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.name, required super.email, required super.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      token: json['token'] ?? json['accessToken'] ?? json['access_token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'token': token,
    };
  }
}


