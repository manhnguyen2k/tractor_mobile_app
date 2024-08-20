import 'package:flutter/material.dart';
import '../../values/app_colors.dart';
//import '../../values/app_strings.dart';
import '../../values/app_string1.dart';
import 'Account_information.screen/Build_profile.dart';
class ManageAccount extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          backgroundColor: AppColors.darkBlue,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title:  Center(child: Text(
            AppStrings1.AccountManageTitle,
            style:const TextStyle(
                color: AppColors.textColor, 
                fontSize: 24.0, 
                fontWeight: FontWeight.normal),
          ),) ,
        ),
      body: ProfileScreen()
    );
    
  }
}