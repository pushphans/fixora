import 'package:flutter/material.dart';

class MyTextfield extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  // ✅ OPTIONAL params (baaki fields affect nahi hongi)
  final bool? readOnly;
  final VoidCallback? onTap;

  const MyTextfield({
    super.key,
    required this.label,
    required this.controller,
    this.readOnly,
    this.onTap,
  });

  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),

        const SizedBox(height: 5),

        Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(15),
          child: TextField(
            controller: widget.controller,
            readOnly: widget.readOnly ?? false, // ✅ default false
            onTap: widget.onTap, // ✅ optional
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
