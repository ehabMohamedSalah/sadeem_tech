import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sadeem_project/core/di/di.dart';
import '../../../../core/resuable_comp/custom_text_button.dart';
import '../../../../core/resuable_comp/custom_text_field.dart';
import '../../../../core/resuable_comp/custom_toast_message.dart';
import '../../../../core/resuable_comp/validator.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/routes_manager.dart';
import '../../../../core/utils/string_manager.dart';
import '../../view_model/auth_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  void _validateAndLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().Login(
        userName: emailController.text,
        password: passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.login),
        ),
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteManager.homeScreen, (_) => false);
              toastMessage(
                message: AppStrings.loginSuccessfully,
                tybeMessage: TybeMessage.positive,
              );
            }
            if (state is LoginErrorState) {
              toastMessage(
                message: state.message.toString(),
                tybeMessage: TybeMessage.negative,
              );
            }
          },
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is LoginLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                          labelText: AppStrings.email,
                          hintText: AppStrings.enterYourEmail,
                          obscureText: false,
                          controller: emailController,
                          keyboard: TextInputType.emailAddress,
                          //validator: Validator.email,
                        ),
                        SizedBox(height: 16.h),
                        CustomTextField(
                          labelText: AppStrings.password,
                          hintText: AppStrings.enterPassword,
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
                          //validator: Validator.password,
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.dontHaveAccount,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(width: 5.w),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, RouteManager.registerScreen);
                              },
                              child: Text(
                                AppStrings.signUp,
                                style: const TextStyle(
                                  decorationColor: ColorManager.pinkBase,
                                  color: ColorManager.pinkBase,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 2.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        CustomTextButton(
                          borderColor: ColorManager.pinkBase,
                          text: AppStrings.login,
                          color: ColorManager.pinkBase,
                          textColor: ColorManager.white,
                          onPressed: () {
                            _validateAndLogin(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
