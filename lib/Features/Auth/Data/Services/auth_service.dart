// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fixora/Core/Utils/utils.dart';
import 'package:fixora/Features/Auth/Data/Models/LoginModels/login_response_model.dart';
import 'package:fixora/Features/Auth/Data/Models/RegisterModels/register_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AuthService {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 60),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    ),
  );

  AuthService() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log("Request is made to ${options.path}");
          log("Request data: ${options.data}");
          return handler.next(options);
        },

        onResponse: (response, handler) {
          log("Response received with status code: ${response.statusCode}");
          log("Response data: ${response.data}");
          return handler.next(response);
        },

        onError: (error, handler) {
          log("Request error: ${error.message}");
          return handler.next(error);
        },
      ),
    );
  }

  //AUTHENTICATION METHODS

  //SIGNUP
  Future<bool> signUp(RegisterRequestModel request) async {
    try {
      var response = await dio.post("/Auth/register", data: request.toMap());
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  //LOGIN
  Future<bool> login(String username, String password) async {
    final devId = Uuid().v4();
    try {
      var response = await dio.post(
        '/Auth/login',
        data: {'username': username, 'password': password, 'deviceId': devId},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = response.data;
        final data = LoginResponseModel.fromMap(jsonData);

        await storeToken(
          accessToken: data.accessToken,
          refreshToken: data.refreshToken,
          accessTokenExpiry: data.accessTokenExpiresAt.toString(),
          refreshTokenExpiry: data.refreshTokenExpiresAt.toString(),
          deviceId: devId,
          accountType: data.accountType,
        );

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  //LOGOUT
  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final deviceId = prefs.getString("device_id");
    final token = prefs.getString("access_token");
    try {
      await prefs.clear();
      return true;
    } catch (e) {
      return false;
    }

    // try {
    //   var response = await dio.post(
    //     "/Auth/logout",
    //     data: {'deviceId': deviceId},
    //     options: Options(headers: {"Authorization": "Bearer $token"}),
    //   );

    //   if (response.statusCode == 200) {
    //     await prefs.clear();
    //     return true;
    //   } else {
    //     return false;
    //   }
    // } catch (e) {
    //   log("Error logging out $e");
    //   return false;
    // }
  }

  //AUTH CHECK
  Future<bool> authCheck() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
    final refreshToken = prefs.getString("refresh_token");

    try {
      if (refreshToken != null && accessToken != null) {
        log("Refresh token is present : $refreshToken");
        return true;
      } else {
        log("Refresh token is not present");
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  //TOKEN MANAGEMENT METHODS

  //VALIDATE TOKEN
  Future<bool> isAccessTokenValid() async {
    final prefs = await SharedPreferences.getInstance();
    final aToken = prefs.getString("access_token");
    final aTokenExpiry = prefs.getString("access_token_expiry");

    if (aToken == null || aTokenExpiry == null) {
      return false; // No token or expiry
    }

    final currentTime = DateTime.now();
    final expiryTime = DateTime.parse(aTokenExpiry);

    return expiryTime.isAfter(currentTime);
  }

  //REFRESH TOKEN
  Future<bool> refreshAccessToken() async {
    final prefs = await SharedPreferences.getInstance();

    final refreshToken = prefs.getString("refresh_token");
    final deviceId = prefs.getString("device_id");

    try {
      var response = await dio.post(
        '/Auth/refresh',
        data: {'refreshToken': refreshToken, 'deviceId': deviceId},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonData = response.data;
        var data = LoginResponseModel.fromMap(jsonData);

        await storeToken(
          accessToken: data.accessToken,
          refreshToken: data.refreshToken,
          accessTokenExpiry: data.accessTokenExpiresAt.toString(),
          refreshTokenExpiry: data.refreshTokenExpiresAt.toString(),
          deviceId: deviceId!,
          accountType: data.accountType,
        );

        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Token refresh failed: ${e.toString()}");
      return false;
    }
  }

  Future<Map<String, dynamic>> retryWithRefresh(
    Future<Response> Function() apiCall,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final devId = prefs.getString("device_id");
    bool isTokenRefreshed = await refreshAccessToken();

    if (isTokenRefreshed == true) {
      try {
        Response response = await apiCall();

        log("Retry successful with status: ${response.statusCode}");

        final data = LoginResponseModel.fromMap(response.data);

        await storeToken(
          accessToken: data.accessToken,
          refreshToken: data.refreshToken,
          accessTokenExpiry: data.accessTokenExpiresAt.toString(),
          refreshTokenExpiry: data.refreshTokenExpiresAt.toString(),
          deviceId: devId!,
          accountType: data.accountType,
        );

        return {
          'success': true,
          'data': response.data,
          'statusCode': response.statusCode,
        };
      } on DioException catch (e) {
        log("Retry failed: ${e.message}");

        return {
          'success': false,
          'message':
              e.response?.data['message'] ??
              'Request failed after token refresh',
          'statusCode': e.response?.statusCode,
          'error': e.message,
        };
      } catch (e) {
        log("Unexpected error during retry: ${e.toString()}");

        return {
          'success': false,
          'message': 'An unexpected error occurred',
          'error': e.toString(),
        };
      }
    } else {
      log("Token refresh failed. Logging out user...");
      await logout();

      return {
        'success': false,
        'message': 'Session expired. Please login again.',
        'statusCode': 401,
        'requiresLogin': true, // ✅ Extra flag for UI
      };
    }
  }

  //SHARED PREFERENCES METHODS

  //STORE TOKEN
  Future<void> storeToken({
    required String accessToken,
    required String refreshToken,
    required String accessTokenExpiry,
    required String refreshTokenExpiry,
    required String deviceId,
    required String accountType,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("access_token", accessToken);
    await prefs.setString("refresh_token", refreshToken);
    await prefs.setString("access_token_expiry", accessTokenExpiry);
    await prefs.setString("refresh_token_expiry", refreshTokenExpiry);
    await prefs.setString("device_id", deviceId);
    await prefs.setString("account_type", accountType);
  }
}
