import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tractorapp/utils/helpers/snackbar_helper.dart';
import 'package:tractorapp/values/app_regex.dart';
import 'dart:developer';
import '../components/app_text_form_field.dart';
import '../resources/resources.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_constants.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';
import '../service/Auth.service/Auth.service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:developer';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

 Future<void> _login() async {
    print('logggggggggg');
    final String username =emailController.text;
    final String password = passwordController.text;

    // Replace with your API endpoint
   // final String url = 'https://example.com/api/login';

    try {
    
      final response = await AuthService.logIn(username, password);
      
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        final Map<String, dynamic> responseData = json.decode(response.body);
        final Map<String, dynamic> userData = (responseData['data']);
        
        print(userData);
        // Check if login was successful
        if (responseData['code']==200) {
         
          log(userData['accessToken']);
          
         
         Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
_sprefs.then((prefs) {
  // ...
  prefs.setString('accesstoken', userData['accessToken']);
  prefs.setString('uid', userData['_id']);
  prefs.setBool('isLogin',true);
  log('done');
    NavigationHelper.pushReplacementNamed(
                                AppRoutes.home,
                              );
                              emailController.clear();
                                passwordController.clear();
}, 
onError: (error) {
  print("SharedPreferences ERROR = $error");   
});
          log('done');
 
        } else {
          // Show error message
          _showError(responseData['message']);
        }
      } else {
        // If the server returns an unexpected response, show an error
        _showError('Server error: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      // Handle any errors that occur during the HTTP request
      _showError('Error: $e');
    }
  }

 void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  void initializeControllers() {
    emailController = TextEditingController()..addListener(controllerListener);
    passwordController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  void controllerListener() {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty && password.isEmpty) return;
    if(!email.isEmpty && !password.isEmpty){
        fieldValidNotifier.value = true;
    };
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const GradientBackground(
            children: [
              Text(
                AppStrings.signInToYourNAccount,
                style: AppTheme.titleLarge,
              ),
              SizedBox(height: 6),
              Text(AppStrings.signInToYourAccount, style: AppTheme.bodySmall),
            ],
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppTextFormField(
                    controller: emailController,
                    labelText: AppStrings.username,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => _formKey.currentState?.validate(),
                    validator: (value) {
                      return value!.isEmpty? AppStrings.pleaseEnterUsername: null;
                          
                          
                    },
                  ),
                  ValueListenableBuilder(
                    valueListenable: passwordNotifier,
                    builder: (_, passwordObscure, __) {
                      return AppTextFormField(
                        obscureText: passwordObscure,
                        controller: passwordController,
                        labelText: AppStrings.password,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (_) => _formKey.currentState?.validate(),
                        validator: (value) {
                          return value!.isEmpty
                              ? AppStrings.pleaseEnterPassword
                              : null;
                                 
                        },
                        suffixIcon: IconButton(
                          onPressed: () =>
                              passwordNotifier.value = !passwordObscure,
                          style: IconButton.styleFrom(
                            minimumSize: const Size.square(48),
                          ),
                          icon: Icon(
                            passwordObscure
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(AppStrings.forgotPassword),
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder(
                    valueListenable: fieldValidNotifier,
                    builder: (_, isValid, __) {
                      return FilledButton(
                        onPressed: isValid
                            ? _login
                            : null,
                        child: const Text(AppStrings.login),
                      );
                    },
                  ),
                
                 
                  const SizedBox(height: 20),
                 
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.doNotHaveAnAccount,
                style: AppTheme.bodySmall.copyWith(color: Colors.black),
              ),
              const SizedBox(width: 4),
              TextButton(
                    onPressed: () { NavigationHelper.pushReplacementNamed(
                                AppRoutes.register,
                              );},
                    child: const Text(AppStrings.register),
                  ),
            ],
          ),
        ],
      ),
    );
  }
}
