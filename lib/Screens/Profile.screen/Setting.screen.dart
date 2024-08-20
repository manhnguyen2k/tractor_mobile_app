import 'package:flutter/material.dart';
import '../../values/app_colors.dart';
//import '../../values/app_strings.dart';
import 'dart:io'; // Needed for exit function
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import '../../values/app_string1.dart';
import 'package:flutter/services.dart';
import '../../provider/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
  String _selectedLanguage = 'Vietnamese';
  bool light = true;

  Future<void> loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final selected = prefs.getString('selected_language');
    log('selected language: $selected');
    setState(() {
      _selectedLanguage = selected ?? 'Vietnamese';
    });
  }

  @override
  void initState() {
    super.initState();
    loadLanguage();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    final titleColor = theme.textTheme.bodyMedium;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.darkBlue,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title:
          Center(
            child:  Text(
            AppStrings1.SettingTitle,
            style: const TextStyle(
                color: AppColors.textColor, // Set the text color here
                fontSize: 24.0, // Set the font size here
                fontWeight: FontWeight.normal),
          ),
          )
          ,
        ),
        body:
            //    color: AppColors.bodyColor,
            Column(
          children: [
            ListTile(
                title: Text(
                  AppStrings1.setting_language,
                  style: titleColor,
                ),
                trailing: SizedBox(
                  width: 70,
                  child: GestureDetector(
                    onTap: () {
                      _showLanguageMenu(context);
                    },
                    child: Image.asset(
                      _selectedLanguage == 'Vietnamese'
                          ? 'assets/image/vietnam.png'
                          : 'assets/image/united-kingdom.png',
                      width: 70,
                      height: 40,
                    ),
                  ),
                )),
            ListTile(
                title: Text(
                  AppStrings1.settings_darkmode,
                  style: titleColor,
                ),
                trailing: SizedBox(
                  width: 70,
                  child: Switch(
                    // This bool value toggles the switch.
                    value: themeProvider.themeMode == ThemeMode.dark,
                    activeColor: AppColors.primaryColor,
                    onChanged: (value) {
                      themeProvider.toggleTheme();
                    },
                  ),
                )),
          ],
        ));
  }

  void _showLanguageMenu(BuildContext context) {
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      initialValue: _selectedLanguage, // Adjust position as needed
      items: const [
        PopupMenuItem<String>(
          value: 'Vietnamese',
          child: Text('Tiếng Việt'),
        ),
        PopupMenuItem<String>(
          value: 'English',
          child: Text('English'),
        ),
      ],
    ).then((value) {
      if (value != null && value != _selectedLanguage) {
        _showExitDialog(context, value);
      }
    });
  }

  void _showExitDialog(BuildContext context, String value) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppStrings1.language_dialog_title),
          content: Text(AppStrings1.language_dialog_body),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppStrings1.language_dialog_notclose),
            ),
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('selected_language', value);
                setState(() {
                  _selectedLanguage = value;
                });
                SystemNavigator.pop();
                // exit(0);
              },
              child: Text(AppStrings1.language_dialog_close),
            ),
          ],
        );
      },
    );
  }
}
