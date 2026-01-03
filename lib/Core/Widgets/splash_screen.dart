import 'package:fixora/Core/Widgets/auth_wrapper.dart';
import 'package:fixora/Presentation/ViewModels/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<void> _initFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initFuture = _initializeApp();
  }

  Future<void> _initializeApp() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await Future.wait([
      Future.delayed(const Duration(seconds: 3)),
      authProvider.authCheck(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const AuthWrapper();
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: Image(
                        image: AssetImage("assets/appicon.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Column(
                      children: [
                        Text(
                          "Welcome to BizConnect!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Your guide to the best services right\naround the corner",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),

                    SizedBox(height: 50),

                    Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
