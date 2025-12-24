import 'dart:developer';

import 'package:fixora/Presentation/ViewModels/profile_provider.dart';
import 'package:fixora/Core/ReusableWidgets/my_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _ProviderProfile();
}

class _ProviderProfile extends State<UserProfile> {
  String dateOfBirth = "N/A";

  String formatDobDDMMYYYY(String isoDateTime) {
    final dateTime = DateTime.parse(isoDateTime).toLocal();

    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year.toString();

    return "$day-$month-$year";
  }

  @override
  void initState() {
    super.initState();
    // Post frame callback - ensure UI builds pehle
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProfile();
    });
  }

  Future<void> _loadProfile() async {
    final provider = Provider.of<ProfileProvider>(context, listen: false);

    await provider.getServiceProviderProfile();

    if (provider.providerProfile != null) {
      final date = await Provider.of<ProfileProvider>(
        context,
        listen: false,
      ).providerProfile?.dateOfBirth;
      if (date != null) {
        dateOfBirth = formatDobDDMMYYYY(date);
      } else {
        dateOfBirth = "N/A";
      }
    } else {
      log("❌ Profile is null after loading");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Consumer<ProfileProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Color(0xFFFF6B35)),
                    SizedBox(height: 16),
                    Text(
                      "Loading profile...",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            // ❌ ERROR STATE - Profile null hai
            if (value.providerProfile == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 60, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      "Failed to load profile",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Please check your connection and try again",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _loadProfile,
                      icon: Icon(Icons.refresh),
                      label: Text("Retry"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF6B35),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://plus.unsplash.com/premium_photo-1681943258709-9137146aa2bf?q=80&w=784&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                        ),
                        radius: 50,
                      ),

                      SizedBox(height: 30),
                      MyCard(
                        text:
                            "${value.providerProfile?.firstName} ${value.providerProfile?.lastName}",
                        label: "Name",
                        icon: Icons.person,
                      ),

                      SizedBox(height: 15),

                      MyCard(
                        text: value.providerProfile?.phoneNumber ?? "N/A",
                        label: "Phone no.",
                        icon: Icons.call,
                      ),

                      SizedBox(height: 15),

                      MyCard(
                        text: value.providerProfile?.defaultCity ?? "N/A",
                        label: "City.",
                        icon: Icons.location_city,
                      ),

                      SizedBox(height: 15),

                      MyCard(
                        text: value.providerProfile?.bio ?? "N/A",
                        label: "Bio",
                        icon: Icons.info,
                      ),

                      SizedBox(height: 15),

                      MyCard(
                        text: dateOfBirth,
                        label: "Date of birth",
                        icon: Icons.call,
                      ),

                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FloatingActionButton(
                            backgroundColor: Color(0xFFFF6B35),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/providereditprofile',
                              );
                            },
                            child: Icon(Icons.edit),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
