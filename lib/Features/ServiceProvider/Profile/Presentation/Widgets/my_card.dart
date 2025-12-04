import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  final String text;
  final String label;
  final IconData icon;
  const MyCard({
    super.key,
    required this.text,
    required this.label,
    required this.icon,
  });

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          widget.label,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        SizedBox(height: 3),
        Card(
          elevation: 3,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 17, horizontal: 15),
            child: Row(
              children: [
                Icon(widget.icon),

                SizedBox(width: 20),

                Expanded(
                  child: Text(
                    widget.text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
