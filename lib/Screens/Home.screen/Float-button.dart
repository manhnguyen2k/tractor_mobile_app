import 'package:flutter/material.dart';
import '../../values/app_colors.dart';
class FloatButton extends StatelessWidget {
  FloatButton({
    required this.size,
    required this.color,
    required this.title,
    required this.icon,
    required this.subtitle,
    required this.onTap,
  });

  final Size size;
  final Color color;
  final Icon icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap; 
  
  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
   
     final Color background;
   
    switch (theme.brightness) {
      case Brightness.light:
          background = AppColors.cardBackgroundColor_light;
      case Brightness.dark:
          background = AppColors.cardBackgroundColor;
        
        break;
      default:  background = Colors.white;
    }
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Card(
        color: background,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: InkWell(
          onTap: onTap, // Xử lý sự kiện nhấn
          borderRadius: BorderRadius.circular(
              8.0), // Hiệu ứng ripple theo bo góc của Card
          child: SizedBox(
            height: size.height * .1,
            width: size.width * .39,
            child: Center(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: color,
                  child: icon,
                ),
                title: Text(
                  title,
                  style: const TextStyle(
                      //color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                subtitle: Text(
                  subtitle,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
