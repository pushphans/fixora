// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, '/authwrapper');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 252, 174, 58),
      backgroundColor: const Color(0xfff87e26),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 60),

            // Image Container
            Container(
              decoration: BoxDecoration(
                // color: const Color.fromARGB(255, 252, 174, 58),
                color: const Color(0xfff87e26),
              ),
              child: const Image(
                image: AssetImage("assets/appicon.png"),
                // fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 5),

            // Welcome Text
            const Column(
              children: [
                Text(
                  "Welcome to Fixora!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Your guide to the best services right\naround the corner",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),

            // Loading Indicator
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
