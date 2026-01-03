import 'package:fixora/Core/Widgets/splash_screen.dart';
import 'package:fixora/Presentation/Screens/login_page.dart';
import 'package:fixora/Presentation/Screens/settings_page.dart';
import 'package:fixora/Presentation/Screens/sign_up_page.dart';
import 'package:fixora/Presentation/ViewModels/auth_provider.dart';
import 'package:fixora/Presentation/Screens/ServiceProvide/provider_edit_profile_screen.dart';
import 'package:fixora/Presentation/ViewModels/profile_provider.dart';
import 'package:fixora/Presentation/Screens/ServiceSeeker/user_edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    //multiprovider is used to initialize multiple providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: SplashScreen(),
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/providereditprofile': (context) => EditProfileScreen(),
        '/usereditprofile': (context) => EditUserProfileScreen(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}
