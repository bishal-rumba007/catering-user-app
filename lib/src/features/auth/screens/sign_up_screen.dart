import 'package:catering_user_app/src/common/common_export.dart';
import 'package:catering_user_app/src/common/widgets/build_dialogs.dart';
import 'package:catering_user_app/src/features/auth/screens/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Create an Account',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  BuildTextFormField(
                    controller: _nameController,
                    labelText: 'Full Name',
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter your full name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BuildTextFormField(
                    controller: _emailController,
                    labelText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BuildTextFormField(
                    controller: _phoneController,
                    labelText: 'Phone Number',
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BuildPasswordTextFormField(
                    labelText: 'Password',
                    textInputAction: TextInputAction.done,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final authData = ref.watch(authProvider);
                      return BuildButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final navigator = Navigator.of(context);
                            buildLoadingDialog(context, "Creating account...");
                            final response = await authData.register(
                              name: _nameController.text.trim(),
                              email: _emailController.text.trim(),
                              phone: _phoneController.text.trim(),
                              password: _passwordController.text.trim(),
                            );
                            navigator.pop();
                            if (response != "Registration Successful") {
                              if (!context.mounted) return;
                              buildErrorDialog(
                                  context, "Couldn't create account!");
                            } else {
                              navigator.pushNamed(Routes.mainScreenRoute);
                            }
                          }
                        },
                        buttonWidget: const Text('Create account'),
                      );
                    },
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  Text(
                    'Already have an account?',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.loginRoute);
                    },
                    child: const Text('Login instead'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
