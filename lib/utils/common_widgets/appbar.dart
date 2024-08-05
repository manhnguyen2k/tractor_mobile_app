import 'package:flutter/material.dart';
import '../../values/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;

  CustomAppBar({required this.title, this.actions, this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: leading,
      title: Text(
        title,
        style:  TextStyle(
            color: AppColors.textColor, fontSize: 24.0, fontWeight: FontWeight.normal),
      ),
      actions: actions,
      backgroundColor: AppColors.darkBlue,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
