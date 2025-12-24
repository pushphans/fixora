import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fixora/Core/Utils/utils.dart';

Future<Dio> getAuthDio() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );

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

  return dio;
}
