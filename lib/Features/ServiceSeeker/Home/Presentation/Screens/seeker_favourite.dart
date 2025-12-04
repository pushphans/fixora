import 'package:flutter/material.dart';

class SeekerFavourite extends StatelessWidget {
  const SeekerFavourite({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.favorite_border, size: 80, color: Color(0xFFFF6B35)),
          SizedBox(height: 16),
          Text(
            'Favorites',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Save your favorite services here',
            style: TextStyle(color: Color(0xFF8D8D8D)),
          ),
        ],
      ),
    );
  }
}
