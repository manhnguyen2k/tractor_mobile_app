import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'dart:developer';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  // final void onTa
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final leadingColor = theme.listTileTheme.iconColor;
    final titleStyle = theme.listTileTheme.titleTextStyle;
    final tileColor = theme.listTileTheme.tileColor;
    //log('colorssss: $leadingColor');
    return Container(
      constraints: const BoxConstraints(
        minHeight: 50.0,
      ),
      height: 60,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: onPress,
          child: ListTile(
            tileColor: tileColor,
            leading: Container(
              width: 40,
              height: 40,
              child: Icon(icon, color: leadingColor),
            ),
            title: Text(
              title,
              style: textColor != null
                  ? titleStyle?.copyWith(color: textColor)
                  : titleStyle,
            ),
            trailing: endIcon
                ? Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: const Icon(LineAwesomeIcons.angle_right_solid,
                        size: 18.0, color: Colors.grey)
                      )
                : null,
          ),
        ),
      ),
    );
  }
}
