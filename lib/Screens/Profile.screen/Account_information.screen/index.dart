import 'package:flutter/material.dart';
import '../../../values/app_colors.dart';
//import '../../values/app_strings.dart';
import '../../../values/app_strings.dart';
import 'avatar.dart';
import '../../../utils/common_widgets/appbar.dart';
class ManageAccount extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: CustomAppBar(
        
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title:  AppStrings.AccountManageTitle ,
        ),
      body: ProfileScreen()
    );
    
  }
}