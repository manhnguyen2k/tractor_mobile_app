import 'package:flutter/material.dart';
import 'routes.dart';
import 'utils/helpers/navigation_helper.dart';
import 'utils/helpers/snackbar_helper.dart';
import 'values/app_routes.dart';
import 'values/app_strings.dart';
import 'values/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRegisterApp extends StatelessWidget {
  const LoginRegisterApp({super.key});

  Future<String> _getInitialRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasKey = prefs.containsKey('isLogin'); 
    return hasKey ? 
    AppRoutes.home 
    : AppRoutes.login; 
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getInitialRoute(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            ),
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.loginAndRegister,
            theme: AppTheme.themeData,
            initialRoute: snapshot.data,
            scaffoldMessengerKey: SnackbarHelper.key,
            navigatorKey: NavigationHelper.key,
            onGenerateRoute: Routes.generateRoute,
          );
        }
      },
    );
  }
}
