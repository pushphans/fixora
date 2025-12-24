import 'package:fixora/Data/Services/profile_service.dart';
import 'package:fixora/Presentation/Screens/ServiceProvide/profile_request_model.dart';
import 'package:fixora/Presentation/Screens/ServiceProvide/profile_response_model.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  final providerService = ProfileService();

  ProfileResponseModel? providerProfile;
  bool isLoading = false;
  bool isUpdateSuccess = false;

  Future<void> getServiceProviderProfile() async {
    isLoading = true;

    var result = await providerService.getProviderPersonalProfile();

    if (result != null) {
      providerProfile = result;
    } else {
      providerProfile = null;
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> setServiceProviderProfile(ProfileRequestModel request) async {
    isLoading = true;

    var result = await providerService.setProviderProfile(request);

    if (result != null) {
      isUpdateSuccess = true;
    } else {
      isUpdateSuccess = false;
    }

    await getServiceProviderProfile();

    isLoading = false;
    notifyListeners();
  }
}
