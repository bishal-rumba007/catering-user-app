
import 'package:catering_user_app/src/common/common_export.dart';
import 'package:catering_user_app/src/features/auth/screens/auth_provider.dart';
import 'package:catering_user_app/src/features/auth/screens/sign_up_screen.dart';
import 'package:catering_user_app/src/common/widgets/build_dialogs.dart';
import 'package:catering_user_app/src/features/dashboard/screens/home_screen.dart';
import 'package:catering_user_app/src/themes/export_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  /// boolean variable to check if remember me is clicked or not
  bool _isChecked = false;

  late Box box1;

  @override
  void initState() {
    super.initState();
    createOpenBox();
  }

  /// create a box with this function below
  void createOpenBox() async {
    box1 = await Hive.openBox('loginData');
    getData();
  }


  /// gets the stored data from the box and assigns it to the controllers
  void getData() async {
    if (box1.get('username') != null) {
      _usernameController.text = box1.get('username');
      _isChecked = true;
      setState(() {});
    }
    if (box1.get('password') != null) {
      _passwordController.text = box1.get('password');
      _isChecked = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Login',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  BuildTextFormField(
                    controller: _usernameController,
                    labelText: 'Username',
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
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
                  SizedBox(height: 14.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (value) {
                          _isChecked = !_isChecked;
                          removeLoginInfo();
                          setState(() {});
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        activeColor: AppColor.primaryRed,
                        checkColor: Colors.white,
                        side: const BorderSide(
                          color: AppColor.greyColor,
                          width: 1.4
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      SizedBox(width: 6.w,),
                      Text("Remember Me",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.h),
                  Consumer(
                    builder: (context, ref, child) {
                      final authData = ref.watch(authProvider);
                     return BuildButton(
                       onPressed: () async{
                         if(_formKey.currentState!.validate()){
                           final navigator = Navigator.of(context);
                           buildLoadingDialog(context, "Logging in..");
                           login();
                           final response = await authData.login(
                             email: _usernameController.text.trim(),
                             password: _passwordController.text.trim(),
                           );
                           navigator.pop();
                           if(response != 'Login Successful'){
                             if(!context.mounted) return;
                             buildErrorDialog(context, response);
                           }else{
                             navigator.push(MaterialPageRoute(builder: (_) => const HomeScreen(),));
                           }
                         }
                       },
                       buttonWidget: const Text('Login'),
                     );
                    }
                  ),
                  SizedBox(height: 60.h,),
                  Text(
                    'Don\'t have an account?',
                    style: Theme.of(context).textTheme.bodyMedium
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen(),));
                    },
                    child: const Text('Create an account'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// adds the user info into (box) the local database (Hive)
  void login() {
    if (_isChecked) {
      box1.put('username', _usernameController.value.text);
      box1.put('password', _passwordController.value.text);
    }
  }

  /// clears the box or removes the stored credentials.
  void removeLoginInfo(){
    if(!_isChecked){
      box1.clear();
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}