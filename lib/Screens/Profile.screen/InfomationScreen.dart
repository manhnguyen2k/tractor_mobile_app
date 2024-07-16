import 'package:flutter/material.dart';
import '../../values/app_colors.dart';
import '../../values/app_strings.dart';
class Infomation extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          backgroundColor: AppColors.darkBlue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.textColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            AppStrings.InfomationTitle,
            style: TextStyle(
                color: AppColors.textColor, // Set the text color here
                fontSize: 24.0, // Set the font size here
                fontWeight: FontWeight.normal),
          ),
        ),
      body: Center(child: Text(AppStrings.InfomationTitle)),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}