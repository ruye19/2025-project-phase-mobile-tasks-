import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/exception.dart';
import '../../../models/user_model.dart';
import 'auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String _userKey = 'AUTH_USER';
  static const String _tokenKey = 'AUTH_TOKEN';

  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUser(UserModel user) async {
    await sharedPreferences.setString(_userKey, jsonEncode(user.toJson()));
    await sharedPreferences.setString(_tokenKey, user.token);
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final jsonString = sharedPreferences.getString(_userKey);
    if (jsonString == null) return null;
    try {
      return UserModel.fromJson(jsonDecode(jsonString));
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> clear() async {
    await sharedPreferences.remove(_userKey);
    await sharedPreferences.remove(_tokenKey);
  }
}


