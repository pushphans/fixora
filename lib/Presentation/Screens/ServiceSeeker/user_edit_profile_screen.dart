import 'package:fixora/Core/ReusableWidgets/my_textfield.dart';
import 'package:fixora/Presentation/Screens/ServiceProvide/profile_request_model.dart';
import 'package:fixora/Presentation/Screens/ServiceProvide/profile_response_model.dart';
import 'package:fixora/Presentation/ViewModels/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditUserProfileScreen extends StatefulWidget {
  const EditUserProfileScreen({super.key});

  @override
  State<EditUserProfileScreen> createState() => EditUserProfileScreenState();
}

class EditUserProfileScreenState extends State<EditUserProfileScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();
  final cityController = TextEditingController();
  final dobController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initalSetup();
  }

  Future<void> initalSetup() async {
    await Provider.of<ProfileProvider>(
      context,
      listen: false,
    ).getServiceProviderProfile();

    ProfileResponseModel? profile = Provider.of<ProfileProvider>(
      context,
      listen: false,
    ).providerProfile;

    if (profile != null) {
      firstNameController.text = profile.firstName ?? "";
      lastNameController.text = profile.lastName ?? "";
      phoneController.text = profile.phoneNumber ?? "";
      bioController.text = profile.bio ?? "";
      cityController.text = profile.defaultCity ?? "";
      dobController.text = profile.dateOfBirth ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFFFF6B35),
        title: Text(
          "Edit Profile",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
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

              MyTextfield(label: "Last Name", controller: lastNameController),

              SizedBox(height: 20),

              MyTextfield(label: "Phone", controller: phoneController),

              SizedBox(height: 20),

              MyTextfield(label: "Bio", controller: bioController),

              SizedBox(height: 20),

              MyTextfield(label: "City", controller: cityController),

              SizedBox(height: 20),

              MyTextfield(
                label: "Date of Birth",
                controller: dobController,
                readOnly: true,
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                  );

                  if (selectedDate != null) {
                    // ✅ DOB ke liye midnight UTC best practice
                    final isoDob = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                    ).toUtc().toIso8601String();

                    dobController.text = isoDob;
                  }
                },
              ),

              SizedBox(height: 50),

              Consumer<ProfileProvider>(
                builder: (context, value, child) => Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF6B35),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: MaterialButton(
                    onPressed: () async {
                      ProfileRequestModel request = ProfileRequestModel(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        phoneNumber: phoneController.text,
                        bio: bioController.text,
                        defaultCity: cityController.text,
                        dateOfBirth: dobController.text,
                      );

                      await value.setServiceProviderProfile(request);

                      if (value.isUpdateSuccess == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green,
                            content: Text("Update successful 👍"),
                          ),
                        );

                        if (mounted) {
                          Navigator.pop(context);
                        } else {
                          return;
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                            content: Text("Update failed 😓"),
                          ),
                        );
                      }
                    },
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
