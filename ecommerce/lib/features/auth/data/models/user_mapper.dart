import '../../domain/entities/user.dart';
import 'user_model.dart';

extension UserModelMapper on UserModel {
  User toEntity() {
    return User(
      id: id,
      email: email,
      name: name,
      token: token,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension UserEntityMapper on User {
  UserModel toModel() {
    return UserModel(
      id: id,
      email: email,
      name: name,
      token: token,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
