import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fixora/Core/Utils/utils.dart';
import 'package:fixora/Features/Auth/Data/Services/auth_service.dart';
import 'package:fixora/Features/ServiceProvider/Profile/Data/Models/profile_request_model.dart';
import 'package:fixora/Features/ServiceProvider/Profile/Data/Models/profile_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceProviderProfileService {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 60),
    ),
  );

  final authService = AuthService();

  ServiceProviderProfileService() {
    dio.interceptors.add(
      InterceptorsWrapper(onRequest: onRequest, onError: onError),
    );
  }

  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("acces_token");

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  Future<void> onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    if ((error.response?.statusCode == 401)) {
      log("401 found, refreshing token...");

      final tokenRefreshedOrNot = await authService.refreshAccessToken();

      if (tokenRefreshedOrNot == true) {
        String? newToken = prefs.getString("access_token");

        final retryOptions = Options(
          method: error.requestOptions.method,
          headers: error.requestOptions.headers,
        );

        retryOptions.headers!['Authorization'] = 'Bearer $newToken';

        try {
          final response = await dio.request(
            error.requestOptions.path,
            options: retryOptions,
            data: error.requestOptions.data,
            queryParameters: error.requestOptions.queryParameters,
          );

          log("Retry successful");

          return handler.resolve(response);
        } catch (e) {
          log("Retry failed: $e");

          return handler.reject(error);
        }
      } else {
        log("Refreshing token failed, logging out...");
        return handler.reject(error);
      }
    } else {
      return handler.next(error);
    }
  }

  Future<ProfileResponseModel?> setProviderProfile(
    ProfileRequestModel request,
  ) async {
    try {
      Response response = await dio.put('/v1/user/me');

      if (response.statusCode == 200) {
        var jsonData = response.data;
        final data = ProfileResponseModel.fromMap(jsonData);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
