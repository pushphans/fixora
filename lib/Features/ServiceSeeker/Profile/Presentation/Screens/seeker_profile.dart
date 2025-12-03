import 'package:flutter/material.dart';

class SeekerProfile extends StatelessWidget {
  const SeekerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircleAvatar(
            radius: 50,
            backgroundColor: Color(0xFF4ECDC4),
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          SizedBox(height: 16),
          Text(
            'User Profile',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Manage your account settings',
            style: TextStyle(color: Color(0xFF8D8D8D)),
          ),
        ],
      ),
    );
  }
}
