import 'package:fixora/Presentation/Screens/login_page.dart';
import 'package:fixora/Presentation/ViewModels/auth_provider.dart';
import 'package:fixora/Presentation/Screens/ServiceProvide/provider_dashboard.dart';
import 'package:fixora/Presentation/Screens/ServiceSeeker/user_dashboard.dart';
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
            return const UserDashboard();
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
