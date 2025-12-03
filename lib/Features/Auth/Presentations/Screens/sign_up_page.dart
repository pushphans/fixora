// ignore_for_file: use_build_context_synchronously

import 'package:fixora/Features/Auth/Data/Models/RegisterModels/register_request_model.dart';
import 'package:fixora/Features/Auth/Presentations/ViewModels/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptTerms = false;
  String? _selectedUserType;

  final List<String> _userTypes = ['User', 'Service Provider'];

  @override
  void dispose() {
    userNameController.dispose();
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
                const SizedBox(height: 20),

                /// LOGO
                Center(
                  child: Image.asset(
                    "assets/appicon.png",
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 10),

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

                /// FULL NAME
                _buildInput(
                  controller: userNameController,
                  label: "Full Name",
                  hint: "Enter your full name",
                  icon: Icons.person_outline,
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
                  onChanged: (v) => setState(() => _selectedUserType = v),
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
                  builder: (context, value, child) => ElevatedButton(
                    onPressed: () async {
                      final RegisterRequestModel request = RegisterRequestModel(
                        username: userNameController.text.trim(),
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        confirmPassword: confirmPasswordController.text.trim(),
                        accountType: _selectedUserType!,
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
                            behavior: SnackBarBehavior.floating,
                            content: Text("Sign up failed"),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B35),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

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
