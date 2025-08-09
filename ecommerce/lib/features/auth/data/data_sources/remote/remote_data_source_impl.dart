import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/error/exceptions.dart';
import '../../models/user_model.dart';
import 'remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;
  final String _baseUrl = '$baseUrl/auth';

  AuthRemoteDataSourceImpl({
    required this.client,
    required this.sharedPreferences,
  });

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await client.post(
        Uri.parse('$_baseUrl/login'),
        headers: defaultHeaders,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final user = UserModel.fromJson(responseData['data']);
        
        // Save token to shared preferences
        await sharedPreferences.setString('auth_token', user.token!);
        
        return user;
      } else {
        throw ServerException(
          message: jsonDecode(response.body)['message'] ?? 'Login failed',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password) async {
    try {
      final response = await client.post(
        Uri.parse('$_baseUrl/register'),
        headers: defaultHeaders,
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final user = UserModel.fromJson(responseData['data']);
        
        // Save token to shared preferences
        await sharedPreferences.setString('auth_token', user.token!);
        
        return user;
      } else {
        throw ServerException(
          message: jsonDecode(response.body)['message'] ?? 'Registration failed',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      final token = sharedPreferences.getString('auth_token');
      if (token != null) {
        await client.post(
          Uri.parse('$_baseUrl/logout'),
          headers: {
            ...defaultHeaders,
            'Authorization': 'Bearer $token',
          },
        );
      }
      
      // Clear auth data from shared preferences
      await sharedPreferences.remove('auth_token');
    } catch (e) {
      throw ServerException(message: 'Logout failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final token = sharedPreferences.getString('auth_token');
      if (token == null) {
        throw const UnauthorizedException(message: 'Not authenticated');
      }

      final response = await client.get(
        Uri.parse('$_baseUrl/me'),
        headers: {
          ...defaultHeaders,
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return UserModel.fromJson(responseData['data']);
      } else if (response.statusCode == 401) {
        // Token is invalid or expired
        await sharedPreferences.remove('auth_token');
        throw const UnauthorizedException(message: 'Session expired');
      } else {
        throw ServerException(
          message: jsonDecode(response.body)['message'] ?? 'Failed to get user data',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is! ServerException) {
        throw ServerException(message: 'Failed to get user data: ${e.toString()}');
      }
      rethrow;
    }
  }
}
