import 'package:fixora/Presentation/ViewModels/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneralDrawer extends StatefulWidget {
  const GeneralDrawer({super.key});

  @override
  State<GeneralDrawer> createState() => _GeneralDrawerState();
}

class _GeneralDrawerState extends State<GeneralDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFFFF6B35),
      elevation: 10,

      child: Consumer<AuthProvider>(
        builder: (context, value, child) => Column(
          children: [
            DrawerHeader(
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                ),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/appicon.png"),
                  backgroundColor: Color(0xfff77d24),
                  radius: 55,
                ),
              ),
            ),

            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    title: Text("Settings"),
                    leading: Icon(Icons.settings),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/settings");
                    },
                  ),

                  ListTile(
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    title: Text("Log out"),
                    leading: Icon(Icons.logout),
                    onTap: () {
                      value.logout();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
