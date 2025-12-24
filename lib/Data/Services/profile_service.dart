import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fixora/Core/Widgets/general_dio.dart';
import 'package:fixora/Presentation/Screens/ServiceProvide/profile_request_model.dart';
import 'package:fixora/Presentation/Screens/ServiceProvide/profile_response_model.dart';

class ProfileService {
  Future<ProfileResponseModel?> getProviderPersonalProfile() async {
    final dio = await getGeneralDio();

    try {
      Response response = await dio.get("/v1/users/me");

      if (response.statusCode == 200) {
        var jsonData = response.data;
        final data = ProfileResponseModel.fromMap(jsonData);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ProfileResponseModel?> setProviderProfile(
    ProfileRequestModel request,
  ) async {
    final dio = await getGeneralDio();
    try {
      Response response = await dio.put('/v1/users/me', data: request.toMap());

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
