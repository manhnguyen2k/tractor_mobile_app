import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'utils/helpers/navigation_helper.dart';
import 'utils/helpers/snackbar_helper.dart';
import 'values/app_routes.dart';
import 'values/app_strings.dart';
import 'values/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './values/App_theme1.dart';
import './provider/theme_provider.dart'; 

class TractorApp extends StatelessWidget {
  const TractorApp({super.key});

  Future<String> _getInitialRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin') ?? false;
    return 
    //isLogin ? 
    AppRoutes.home ;
  //  : AppRoutes.login; // Choose the route based on login status
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: FutureBuilder<String>(
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
            final themeProvider = Provider.of<ThemeProvider>(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: AppStrings.loginAndRegister,
              theme: AppTheme1.lightTheme, 
              darkTheme: AppTheme1.darkTheme, 
              themeMode: themeProvider.themeMode, 
              initialRoute: snapshot.data,
              scaffoldMessengerKey: SnackbarHelper.key,
              navigatorKey: NavigationHelper.key,
              onGenerateRoute: Routes.generateRoute,
            );
          }
        },
      ),
    );
  }
}
