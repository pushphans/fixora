import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fixora/Core/Utils/utils.dart';
import 'package:fixora/Data/Services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Dio> getGeneralDio() async {
  //created a dio instance
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );

  //instance of auth service for usage
  final authService = AuthService();

  //interceptors
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        //added access token in on request interceptor
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString("access_token");

        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        log("Request: ${options.method} ${options.path}");

        log("Requested date: ${options.data}");
        handler.next(options);
      },

      //handling 401 error with retry logic
      onError: (error, handler) async {
        final prefs = await SharedPreferences.getInstance();

        //check if the response status code is 401
        if ((error.response?.statusCode == 401)) {
          log("401 found, refreshing token...");

          //refresh the access token and the function will store the new access token in the shared preferences by itself
          final tokenRefreshedOrNot = await authService.refreshAccessToken();

          //if refreshing the access token it successful get the new access token from shared preferences
          if (tokenRefreshedOrNot == true) {
            String? newToken = prefs.getString("access_token");

            //make options and add http method, and headers from the previous request
            final retryOptions = Options(
              method: error.requestOptions.method,
              headers: error.requestOptions.headers,
            );

            //add new access token in place of old one in the retry request
            retryOptions.headers!['Authorization'] = 'Bearer $newToken';

            //send request again with new access token like path, options, data, queryparameters
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
      },

      onResponse: (response, handler) {
        log("Response: ${response.statusCode} ${response.requestOptions.path}");
        log("Response data: ${response.data}");
        return handler.next(response);
      },
    ),
  );

  return dio;
}
