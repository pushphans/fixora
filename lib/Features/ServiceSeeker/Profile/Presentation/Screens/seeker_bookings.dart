import 'package:flutter/material.dart';

class SeekerBookings extends StatelessWidget {
  const SeekerBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.book_online, size: 80, color: Color(0xFF4ECDC4)),
          SizedBox(height: 16),
          Text(
            'My Bookings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Your booked services will appear here',
            style: TextStyle(color: Color(0xFF8D8D8D)),
          ),
        ],
      ),
    );
  }
}
