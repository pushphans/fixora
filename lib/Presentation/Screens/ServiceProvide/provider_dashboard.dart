import 'package:fixora/Core/Widgets/general_drawer.dart';
import 'package:fixora/Presentation/Screens/ServiceProvide/provider_bookings.dart';
import 'package:fixora/Presentation/Screens/ServiceProvide/provider_home.dart';
import 'package:fixora/Presentation/Screens/ServiceProvide/provider_services.dart';
import 'package:fixora/Presentation/Screens/ServiceProvide/provider_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProviderDashboard extends StatefulWidget {
  const ProviderDashboard({super.key});

  @override
  State<ProviderDashboard> createState() => _ProviderDashboardState();
}

class _ProviderDashboardState extends State<ProviderDashboard> {
  int selectedIndex = 0;

  void changePage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> pages = [
    ProviderHome(),
    ProviderBookings(),
    ProviderServices(),
    ProviderProfile(),
  ];

  List<String> appBarTitles = ["Home", "Bookings", "Services", "Profile"];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text(
            appBarTitles[selectedIndex],
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFFFF6B35),
        ),

        drawer: GeneralDrawer(),

        body: pages[selectedIndex],

        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.ads_click),
              label: "Bookings",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.miscellaneous_services_outlined),
              label: "Services",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],

          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFFFF6B35),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,

          currentIndex: selectedIndex,
          onTap: (value) {
            changePage(value);
          },
        ),
      ),
    );
  }
}
