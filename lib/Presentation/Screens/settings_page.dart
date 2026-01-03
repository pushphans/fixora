// ignore_for_file: use_build_context_synchronously

import 'package:fixora/Core/ReusableWidgets/my_textfield.dart';
import 'package:fixora/Presentation/ViewModels/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  void showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyTextfield(
                label: "Current password",
                controller: currentPasswordController,
              ),

              SizedBox(height: 20),

              MyTextfield(
                label: "New password",
                controller: newPasswordController,
              ),

              SizedBox(height: 20),

              MyTextfield(
                label: "Confirm new password",
                controller: confirmNewPasswordController,
              ),

              SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    color: Colors.grey.shade400,
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  SizedBox(width: 10),
                  Consumer<AuthProvider>(
                    builder: (cContext, value, child) => MaterialButton(
                      onPressed: () async {
                        await value.changePassword(
                          currentPasswordController.text.trim(),
                          newPasswordController.text.trim(),
                          confirmNewPasswordController.text.trim(),
                        );

                        if (!mounted) return;
                        Navigator.pop(dialogContext);

                        if (value.isPasswordChanged == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                              content: Text("Password changed successfully"),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              content: Text("Password change failed"),
                            ),
                          );
                        }
                      },
                      color: Color(0xFFFF6B35),
                      child: Text(
                        "Change",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF6B35),
        foregroundColor: Colors.white,
        title: Text(
          "Settings",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 10),

            GestureDetector(
              onTap: () {
                showChangePasswordDialog(context);
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Change password", style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
