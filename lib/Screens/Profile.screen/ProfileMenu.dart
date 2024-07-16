import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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
    return Container(
      constraints: const BoxConstraints(
        minHeight: 50.0, // Minimum height is 50 units
      ),
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.white, // Border color
          width: 0.0, // Border width
        ),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Màu của bóng đổ
            spreadRadius: 1, // Độ rộng bóng đổ
            blurRadius: 5, // Độ mờ của bóng đổ
            offset: Offset(0, 3), // Vị trí bóng đổ (x, y)
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: onPress,
          //splashColor: Colors.blue.withOpacity(0.2), // Màu hiệu ứng khi tap
          // highlightColor: Colors.blue.withOpacity(0.1), // Màu hiệu ứng khi nhấn giữ
          child: ListTile(
            leading: Container(
              width: 40,
              height: 40,
              child: Icon(icon, color: Colors.black),
            ),
            title: Text(
              title,
              style: TextStyle(color: textColor),
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
                        size: 18.0, color: Colors.grey))
                : null,
          ),
        ),
      ),
    );
  }
}
