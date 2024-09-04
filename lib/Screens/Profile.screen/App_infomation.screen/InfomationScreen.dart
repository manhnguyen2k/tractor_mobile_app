import 'package:flutter/material.dart';
import '../../../values/app_colors.dart';
//import '../../values/app_strings.dart';
import '../../../values/app_strings.dart';
import '../../../utils/common_widgets/appbar.dart';

class Infomation extends StatelessWidget {
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
        title: AppStrings.InfomationTitle,
      ),
      body: Center(child: Text(AppStrings.InfomationTitle)),
    );
  }
}
