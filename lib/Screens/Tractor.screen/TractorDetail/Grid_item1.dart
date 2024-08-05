import 'package:flutter/material.dart';
import '../../../values/app_colors.dart';
class GridItem1 extends StatelessWidget {
  GridItem1(
      {required this.title,
      required this.width,
      required this.height,
      required this.value,
      required this.icon});
  final double width;
  final double height;
  final double value;
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            
            borderRadius: BorderRadius.circular(8.0),
            color: AppColors.cardBackgroundColor // Optional: to give rounded corners
            ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center horizontally
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(value.toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))
            ],
          ),
        ));
  }
}
