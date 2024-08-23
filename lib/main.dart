import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import './service/firebase.service/firebase.dart';
import './service/Event.service/Event.service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './values/app_strings.dart';
import 'dart:developer';
 Future  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStrings.loadLanguageStrings();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  // Set the background messaging handler early on, as a named top-level function
  
 SharedPreferences prefs = await SharedPreferences.getInstance();
 final selectedLanguage = prefs.getString('selected_language');
 //final selectedTheme = prefs.getString('theme_mode');
 if (selectedLanguage == null || selectedLanguage.isEmpty) {
  prefs.setString('selected_language', 'Vietnamese');
}

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(ChangeNotifierProvider(
      create: (context) => BoolNotifier(),
      child: const TractorApp(),
    ),),
   
  );
}
