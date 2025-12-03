import 'package:fixora/Features/Auth/Presentations/Screens/login_page.dart';
import 'package:fixora/Features/Auth/Presentations/ViewModels/auth_provider.dart';
import 'package:fixora/Features/ServiceProvider/Profile/Presentation/Screens/provider_dashboard.dart';
import 'package:fixora/Features/ServiceSeeker/Profile/Presentation/Screens/seeker_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});
  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    // Future.microtask(() {

    // });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).authCheck();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // -------------------------
        // NEW LOGIC (same flow)
        // -------------------------
        if (value.isLoggedIn == true && value.accountType != null) {
          if (value.accountType == "Service Provider") {
            return const ProviderDashboard();
          } else if (value.accountType == "User") {
            return const SeekerDashboard();
          } else {
            return const LoginPage();
          }
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
