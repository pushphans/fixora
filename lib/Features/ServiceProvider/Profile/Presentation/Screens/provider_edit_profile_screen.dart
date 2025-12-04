import 'package:fixora/Features/ServiceProvider/Profile/Presentation/Widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();
  final cityController = TextEditingController();
  final dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit profile", style: TextStyle(fontSize: 30)),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 10),

            CircleAvatar(
              backgroundImage: NetworkImage(
                "https://plus.unsplash.com/premium_photo-1681943258709-9137146aa2bf?q=80&w=784&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              ),
              radius: 50,
            ),

            SizedBox(height: 30),

            MyTextfield(label: "First Name", controller: firstNameController),

            SizedBox(height: 20),

            MyTextfield(label: "Last Name", controller: firstNameController),

            SizedBox(height: 20),

            MyTextfield(label: "Phone", controller: firstNameController),

            SizedBox(height: 20),

            MyTextfield(label: "City", controller: firstNameController),

            SizedBox(height: 20),

            MyTextfield(
              label: "Date of Birth",
              controller: firstNameController,
            ),

            SizedBox(height: 50),

            Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xFFFF6B35),
                borderRadius: BorderRadius.circular(15),
              ),
              child: MaterialButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Save",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
