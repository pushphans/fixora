import 'package:fixora/Core/Widgets/auth_wrapper.dart';
import 'package:fixora/Core/Widgets/splash_screen.dart';
import 'package:fixora/Features/Auth/Presentations/ViewModels/auth_provider.dart';
import 'package:fixora/Features/ServiceProvider/Profile/Presentation/Screens/provider_edit_profile_screen.dart';
import 'package:fixora/Features/ServiceProvider/Profile/Presentation/ViewModels/service_provider_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    //multiprovider is used to initialize multiple providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(
          create: (context) => ServiceProviderProfileProvider(),
        ),
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

      initialRoute: '/splashscreen',
      routes: {
        '/splashscreen': (context) => SplashScreen(),
        '/authwrapper': (context) => AuthWrapper(),
        '/editprofile': (context) => EditProfileScreen(),
      },
    );
  }
}
