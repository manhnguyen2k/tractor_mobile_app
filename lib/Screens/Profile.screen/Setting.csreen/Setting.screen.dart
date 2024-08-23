import 'package:flutter/material.dart';
import '../../../values/app_colors.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import '../../../values/app_strings.dart';
import 'package:flutter/services.dart';
import '../../../provider/theme_provider.dart';
import 'package:provider/provider.dart';
import '../../../utils/common_widgets/appbar.dart';
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
        appBar: CustomAppBar(
         
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title:  AppStrings.SettingTitle,
          
        ),
        body:
            Column(
            children: [
              ListTile(
                title: Text(
                  AppStrings.setting_language,
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
                  AppStrings.settings_darkmode,
                  style: titleColor,
                ),
                trailing: SizedBox(
                  width: 70,
                  child: Switch(
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
      initialValue: _selectedLanguage,
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
          title: Text(AppStrings.language_dialog_title),
          content: Text(AppStrings.language_dialog_body),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppStrings.language_dialog_notclose),
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
              child: Text(AppStrings.language_dialog_close),
            ),
          ],
        );
      },
    );
  }
}
