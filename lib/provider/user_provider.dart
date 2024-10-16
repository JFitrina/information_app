import 'package:flutter/material.dart';
import 'package:information_app/models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  String? _accessToken;
  String? _refreshToken;

  User? get user => _user; // เปลี่ยนให้เป็น nullable
  String? get accessToken => _accessToken; // เปลี่ยนให้เป็น nullable
  String? get refreshToken => _refreshToken; // เปลี่ยนให้เป็น nullable

  void onLogin(UserModel userModel) {
    _user = userModel.user;
    _accessToken = userModel.accessToken;
    _refreshToken = userModel.refreshToken;
    notifyListeners();
  }

  void onLogout() {
    _user = null;
    _accessToken = null;
    _refreshToken = null;
    notifyListeners();
  }

  bool isAuthenticated() {
    return _accessToken != null && _refreshToken != null;
  }

  void requestToken(String newToken) {
    _accessToken = newToken;
    notifyListeners();
  }
}
