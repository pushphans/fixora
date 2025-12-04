// ignore_for_file: unused_import, deprecated_member_use

import 'dart:developer';

import 'package:fixora/Features/ServiceSeeker/Home/Presentation/Screens/seeker_bookings.dart';
import 'package:fixora/Features/ServiceSeeker/Home/Presentation/Screens/seeker_favourite.dart';
import 'package:fixora/Features/ServiceSeeker/Home/Presentation/Screens/seeker_home.dart';
import 'package:fixora/Features/ServiceSeeker/Profile/Presentation/Screens/seeker_profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeekerDashboard extends StatefulWidget {
  const SeekerDashboard({super.key});

  @override
  State<SeekerDashboard> createState() => _SeekerDashboardState();
}

class _SeekerDashboardState extends State<SeekerDashboard> {
  int _selectedIndex = 0;

  List<Widget> pages = [
    // SeekerHome(),
    SeekerBookings(),
    SeekerBookings(),
    SeekerFavourite(),
    SeekerProfile(),
  ];

  Future<void> showTokens() async {
    final prefs = await SharedPreferences.getInstance();

    log(prefs.getString("access_token") ?? "");
    log(prefs.getString("refresh_token") ?? "");
    log(prefs.getString("access_token_expiry") ?? "");
    log(prefs.getString("refresh_token_expiry") ?? "");
    log(prefs.getString("device_id") ?? "");
  }

  @override
  void initState() {
    super.initState();
    showTokens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: pages[_selectedIndex]),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFFF6B35),
        unselectedItemColor: const Color(0xFF8D8D8D),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online_outlined),
            activeIcon: Icon(Icons.book_online),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
