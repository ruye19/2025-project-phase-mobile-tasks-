import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../../core/constants/constants.dart';
import '../../../../../core/error/exception.dart';
import '../../../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String _baseUrl;

  AuthRemoteDataSourceImpl({required this.client}) : _baseUrl = '$baseUrl/auth';

  @override
  Future<UserModel> login({required String email, required String password}) async {
    try {
      final response = await client.post(
        Uri.parse('$_baseUrl/login'),
        headers: defaultHeaders,
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(jsonDecode(response.body)['data']);
      } else {
        throw ServerException(message: response.body);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signup({required String name, required String email, required String password}) async {
    try {
      final response = await client.post(
        Uri.parse('$_baseUrl/signup'),
        headers: defaultHeaders,
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body)['data']);
      } else {
        throw ServerException(message: response.body);
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}


