import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:information_app/models/user.dart'; // ตรวจสอบให้แน่ใจว่า UserModel ถูกนิยามที่นี่
import 'package:http/http.dart' as http;
import 'package:information_app/provider/user_provider.dart';
import 'package:information_app/variables.dart';

import '../models/user.dart';
import '../variables.dart'; // ตรวจสอบให้แน่ใจว่าชื่อไฟล์ถูกต้อง

class AuthService {
  // ฟังก์ชัน Login
  Future<UserModel?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$apiURL/api/auth/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(
          response.body)); // ตรวจสอบ UserModel ว่าสามารถสร้างจาก JSON ได้
    } else {
      print('Login Failed: ${response.body}');
      return null;
    }
  }

  // ฟังก์ชัน Register
  Future<void> register(String name, String surname, String email,
      String username, String password, String role) async {
    final response = await http.post(
      Uri.parse('$apiURL/api/auth/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'surname': surname,
        'email': email,
        'username': username,
        'password': password,
        'role': role,
      }),
    );

    if (response.statusCode != 201) {
      print('Registration Failed: ${response.body}');
    }
  }

  // ฟังก์ชัน Refresh Token
  Future<void> refreshToken(UserProvider userProvider) async {
    final refreshToken = userProvider.refreshToken;

    if (refreshToken == null) {
      throw Exception('Refresh token is null');
    }

    final response = await http.post(
      Uri.parse('$apiURL/api/auth/refresh'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'token': refreshToken}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      userProvider.requestToken(responseData['accessToken']);
    } else {
      print('Failed to refresh token: ${response.body}');
      throw Exception('Failed to refresh token: ${response.body}');
    }
  }
}

class UserProvider with ChangeNotifier {
  String? _refreshToken;

  String? get refreshToken => _refreshToken;

  void requestToken(String token) {
    _refreshToken = token;
    notifyListeners();
  }
}
