// ignore_for_file: use_build_context_synchronously

import 'package:fixora/Data/Models/register_request_model.dart';
import 'package:fixora/Presentation/ViewModels/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptTerms = false;
  String _selectedUserType = "User";

  final List<String> _userTypes = ['User', 'Service Provider'];

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f6f6),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// LOGO
                Center(
                  child: Image.asset(
                    "assets/appicon.png",
                    width: 180,
                    fit: BoxFit.cover,
                  ),
                ),

                /// TITLE
                const Text(
                  'Create Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3142),
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Sign up to get started',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Color(0xFF8D8D8D)),
                ),

                const SizedBox(height: 32),

                /// FIRST NAME
                _buildInput(
                  controller: firstNameController,
                  label: "First Name",
                  hint: "Enter your first name",
                  icon: Icons.person,
                  validator: (v) => v == null || v.isEmpty
                      ? "Please enter your first name"
                      : null,
                ),

                const SizedBox(height: 16),

                /// LAST NAME
                _buildInput(
                  controller: lastNameController,
                  label: "Last Name",
                  hint: "Enter your last name",
                  icon: Icons.person,
                  validator: (v) => v == null || v.isEmpty
                      ? "Please enter your last name"
                      : null,
                ),

                const SizedBox(height: 16),

                /// PHONE NUMBER
                _buildInput(
                  controller: phoneController,
                  label: "Phone Number",
                  hint: "Enter your phone number",
                  icon: Icons.call_outlined,
                  validator: (v) =>
                      v == null || v.isEmpty ? "Please enter your name" : null,
                ),

                const SizedBox(height: 16),

                /// EMAIL
                _buildInput(
                  controller: emailController,
                  label: "Email",
                  hint: "Enter your email",
                  icon: Icons.email_outlined,
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Please enter your email";
                    }
                    if (!v.contains("@")) return "Enter a valid email";
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                /// USER TYPE
                DropdownButtonFormField<String>(
                  initialValue: _selectedUserType,
                  decoration: _inputDecoration(
                    label: "I am a",
                    hint: "Select account type",
                    icon: Icons.account_circle_outlined,
                  ),
                  items: _userTypes.map((type) {
                    return DropdownMenuItem(value: type, child: Text(type));
                  }).toList(),
                  onChanged: (v) {
                    setState(() {
                      _selectedUserType = v!;
                    });
                  },
                  validator: (v) =>
                      v == null ? "Please select account type" : null,
                ),

                const SizedBox(height: 16),

                /// PASSWORD
                _buildPasswordInput(
                  controller: passwordController,
                  obscure: _obscurePassword,
                  onToggle: () => setState(() {
                    _obscurePassword = !_obscurePassword;
                  }),
                  label: "Password",
                  hint: "Enter your password",
                ),

                const SizedBox(height: 16),

                /// CONFIRM PASSWORD
                _buildPasswordInput(
                  controller: confirmPasswordController,
                  obscure: _obscureConfirmPassword,
                  onToggle: () => setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  }),
                  label: "Confirm Password",
                  hint: "Re-enter your password",
                ),

                const SizedBox(height: 16),

                /// TERMS
                Row(
                  children: [
                    Checkbox(
                      value: _acceptTerms,
                      onChanged: (v) =>
                          setState(() => _acceptTerms = v ?? false),
                      activeColor: const Color(0xFFFF6B35),
                    ),
                    Expanded(
                      child: Wrap(
                        children: const [
                          Text(
                            "I agree to the ",
                            style: TextStyle(color: Color(0xFF8D8D8D)),
                          ),
                          Text(
                            "Terms & Conditions",
                            style: TextStyle(
                              color: Color(0xFFFF6B35),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            " and ",
                            style: TextStyle(color: Color(0xFF8D8D8D)),
                          ),
                          Text(
                            "Privacy Policy",
                            style: TextStyle(
                              color: Color(0xFFFF6B35),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// SIGNUP BUTTON
                Consumer<AuthProvider>(
                  builder: (context, value, child) => Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFF6B35),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: MaterialButton(
                      splashColor: Color(0xFFFF6B35),
                      onPressed: () async {
                        if (firstNameController.text.isNotEmpty ||
                            lastNameController.text.isNotEmpty ||
                            phoneController.text.isNotEmpty ||
                            emailController.text.isNotEmpty ||
                            passwordController.text.isNotEmpty ||
                            confirmPasswordController.text.isNotEmpty) {
                          final RegisterRequestModel request =
                              RegisterRequestModel(
                                firstName: firstNameController.text.trim(),
                                lastName: lastNameController.text.trim(),
                                username: phoneController.text.trim(),
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                confirmPassword: confirmPasswordController.text
                                    .trim(),
                                accountType: _selectedUserType,
                              );

                          await value.signup(request);

                          if (value.isSignUpSuccess == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.green,
                                content: Text("Sign up successful"),
                              ),
                            );
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                content: Text("Sign up failed"),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.grey,
                              behavior: SnackBarBehavior.floating,
                              content: Text("Please fill in all the details"),
                            ),
                          );
                        }
                      },

                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),

                /// LOGIN LINK
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 14, color: Color(0xFF8D8D8D)),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Color(0xFFFF6B35),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// REUSABLE TEXT INPUT
  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: _inputDecoration(label: label, hint: hint, icon: icon),
    );
  }

  /// REUSABLE PASSWORD INPUT
  Widget _buildPasswordInput({
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback onToggle,
    required String label,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: (v) =>
          v == null || v.isEmpty ? "This field is required" : null,
      decoration: _inputDecoration(label: label, hint: hint, icon: Icons.lock)
          .copyWith(
            suffixIcon: IconButton(
              onPressed: onToggle,
              icon: Icon(
                obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: const Color(0xFF8D8D8D),
              ),
            ),
          ),
    );
  }

  /// COMMON INPUT DECORATION
  InputDecoration _inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: const Color(0xFF8D8D8D)),
      filled: true,
      fillColor: const Color(0xFFFAFAFA),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFF6B35), width: 2),
      ),
    );
  }
}
