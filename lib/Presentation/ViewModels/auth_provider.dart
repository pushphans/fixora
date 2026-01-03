import 'package:fixora/Data/Models/AuthModels/register_request_model.dart';
import 'package:fixora/Domain/Respositories/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService();

  // -------------------------
  // MAIN AUTH STATES
  // -------------------------
  bool isLoading = false;
  bool isLoggedIn = false;
  bool hasProfile = false;
  bool isPasswordChanged = false;
  String? accountType;
  String? error;

  // -------------------------
  // SIGNUP STATES
  // -------------------------
  bool isSignUpLoading = false;
  bool isSignUpSuccess = false;
  String? signUpError;

  // -------------------------
  // LOGIN FUNCTION
  // -------------------------
  Future<void> login(String username, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    final result = await _service.login(username, password);

    if (result == true) {
      final prefs = await SharedPreferences.getInstance();
      accountType = prefs.getString("account_type");

      isLoggedIn = true;
      error = null;
    } else {
      isLoggedIn = false;
      hasProfile = false;
      error = "Invalid username or password";
    }

    isLoading = false;
    notifyListeners();
  }

  // -------------------------
  // LOGOUT
  // -------------------------
  Future<void> logout() async {
    isLoading = true;
    notifyListeners();

    await _service.logout();

    isLoggedIn = false;
    accountType = null;

    isLoading = false;
    notifyListeners();
  }

  // -------------------------
  // AUTH CHECK ON APP OPEN
  // -------------------------
  Future<void> authCheck() async {
    isLoading = true;

    final ok = await _service.authCheck();

    if (ok == true) {
      final prefs = await SharedPreferences.getInstance();
      accountType = prefs.getString("account_type");

      isLoggedIn = true;
    } else {
      isLoggedIn = false;
      accountType = null;
    }

    isLoading = false;
    notifyListeners();
  }

  // -------------------------
  // SIGNUP FUNCTION (Independent)
  // -------------------------
  Future<void> signup(RegisterRequestModel request) async {
    isSignUpLoading = true;
    isSignUpSuccess = false;
    signUpError = null;
    notifyListeners();

    final result = await _service.signUp(request);

    if (result == true) {
      isSignUpSuccess = true;
      hasProfile = true;
    } else {
      isSignUpSuccess = false;
      signUpError = "Signup failed. Please try again.";
      hasProfile = false;
    }

    isSignUpLoading = false;
    notifyListeners();
  }

  // -------------------------
  // RESET PASSWORD FUNCTION
  // -------------------------

  Future<void> changePassword(
    String currentPassword,
    String newPassword,
    String confirmNewPassword,
  ) async {
    isLoading = true;
    notifyListeners();
    try {
      final result = await _service.changePassword(
        currectPassword: currentPassword,
        newPassword: newPassword,
        confirmNewPassword: confirmNewPassword,
      );

      if (result == true) {
        isPasswordChanged = true;
      } else {
        isPasswordChanged = false;
      }
    } catch (e) {
      isPasswordChanged = false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
