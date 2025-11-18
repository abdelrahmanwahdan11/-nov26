import 'package:flutter/material.dart';

class AuthController {
  final ValueNotifier<bool> isLoggedIn = ValueNotifier(false);
  final ValueNotifier<String?> userEmail = ValueNotifier(null);

  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    userEmail.value = email;
    isLoggedIn.value = true;
  }

  Future<void> register(String email, String password) async {
    await login(email, password);
  }

  void logout() {
    isLoggedIn.value = false;
    userEmail.value = null;
  }
}
