import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProviderProfile extends StatefulWidget {
  const ProviderProfile({super.key});

  @override
  State<ProviderProfile> createState() => _ProviderProfile();
}

class _ProviderProfile extends State<ProviderProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController areaController = TextEditingController();

  File? profileImage;
  String? gender;
  DateTime? dob;
  String preferredLanguage = "English";

  final languages = ["English", "Hindi", "Gujarati", "Marathi"];

  Future pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => profileImage = File(picked.path));
  }

  Future pickDob() async {
    final result = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (result != null) setState(() => dob = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.3,
        centerTitle: true,
        title: const Text(
          "Complete Profile",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------- Avatar -----------------
            Center(
              child: GestureDetector(
                onTap: pickImage,
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: profileImage != null
                      ? FileImage(profileImage!)
                      : null,
                  child: profileImage == null
                      ? Icon(
                          Icons.person,
                          size: 48,
                          color: Colors.grey.shade600,
                        )
                      : null,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ----------------- Full Name -----------------
            const Text(
              "Full Name",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: nameController,
              maxLength: 40,
              decoration: InputDecoration(
                hintText: "Enter your name",
                counterText: "",
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // ----------------- Gender -----------------
            const Text(
              "Gender",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: gender,
                  hint: const Text("Select gender"),
                  items: ["Male", "Female", "Other"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() => gender = v),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // ----------------- DOB -----------------
            const Text(
              "Date of Birth",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            GestureDetector(
              onTap: pickDob,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  dob == null
                      ? "Select your DOB"
                      : "${dob!.day}/${dob!.month}/${dob!.year}",
                  style: TextStyle(
                    color: dob == null ? Colors.grey.shade600 : Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // ----------------- Preferred Language -----------------
            const Text(
              "Preferred Language",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: preferredLanguage,
                  items: languages
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() => preferredLanguage = v!),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // ----------------- Area -----------------
            const Text(
              "Area / Neighborhood",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: areaController,
              maxLength: 50,
              decoration: InputDecoration(
                hintText: "Enter your area",
                counterText: "",
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ----------------- Save button -----------------
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Save & Continue",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
