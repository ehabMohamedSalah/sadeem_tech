import 'package:flutter/material.dart';
import 'package:sadeem_project/core/utils/routes_manager.dart';

import '../../../../core/constant.dart';
import '../../../../core/resuable_comp/custom_text_button.dart';
import '../../../../core/resuable_comp/custom_text_field.dart';
import '../../../../core/utils/color_manager.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool _isPasswordVisible = false;

  final GlobalKey<FormState> formKey = GlobalKey();
  String? selectedGender;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        labelText: "First Name",
                        hintText: "Enter First Name",
                        controller: firstNameController,
                        keyboard: TextInputType.text,
                        validator: (data) => (data?.isEmpty ?? true)
                            ? 'Invalid first name'
                            : null,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: CustomTextField(
                        labelText: "Last Name",
                        hintText: "Enter Last Name",
                        controller: lastNameController,
                        keyboard: TextInputType.text,
                        validator: (data) => (data?.isEmpty ?? true)
                            ? 'Invalid last name'
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  labelText: "Email",
                  hintText: "Enter Your Email",
                  controller: emailController,
                  keyboard: TextInputType.emailAddress,
                  validator: (data) {
                    if (data == null || data.isEmpty || !data.contains('@')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        labelText: "Password",
                        hintText: "Enter Password",
                        controller: passwordController,
                        keyboard: TextInputType.text,
                        obscureText: !_isPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        validator: (data) {
                          if (data == null || data.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (data.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          final passwordPattern = Constant.regexPass;
                          if (!passwordPattern.hasMatch(data)) {
                            return 'Please enter a correct password';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: CustomTextField(
                        labelText: "Confirm Password",
                        hintText: "Confirm Password",
                        controller: rePasswordController,
                        keyboard: TextInputType.text,
                        obscureText: !_isPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        validator: (data) {
                          if (data == null || data.isEmpty) {
                            return 'Please enter your password confirmation';
                          }
                          if (data != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  labelText: "Phone Number",
                  hintText: "Enter Phone Number",
                  controller: phoneController,
                  keyboard: TextInputType.phone,
                  validator: (data) => (data?.isEmpty ?? true)
                      ? 'Invalid phone number'
                      : null,
                ),
                const SizedBox(height: 30),
                FormField<String>(
                  validator: (value) {
                    if (selectedGender == null) {
                      return 'Please select a gender';
                    }
                    return null;
                  },
                  builder: (FormFieldState<String> state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Gender",
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black54)),
                            const SizedBox(width: 40),
                            Row(
                              children: [
                                Radio<String>(
                                  value: "Male",
                                  groupValue: selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value;
                                      state.didChange(value);
                                    });
                                  },
                                ),
                                Text("Male"),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Row(
                              children: [
                                Radio<String>(
                                  value: "Female",
                                  groupValue: selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value;
                                      state.didChange(value);
                                    });
                                  },
                                ),
                                Text("Female"),
                              ],
                            ),
                          ],
                        ),
                        if (state.hasError)
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              state.errorText!,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 8),

                  SizedBox(height: 40),
                CustomTextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // handle sign-up logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Registration Successful!')),
                      );
                    }
                  },
                  borderColor: ColorManager.pinkBase,
                  text: "Sign Up",
                  color: ColorManager.primaryColor,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",
                        style: const TextStyle(fontSize: 17)),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, RouteManager.loginScreen);
                      },
                      child: Text("Login",
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: ColorManager.pinkBase,
                              decoration: TextDecoration.underline)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
