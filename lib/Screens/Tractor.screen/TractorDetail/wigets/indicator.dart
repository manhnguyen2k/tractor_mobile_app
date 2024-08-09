import 'package:flutter/material.dart';
import '../../../../values/app_colors.dart';
class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    required this.width,
    this.size = 16,
    this.textColor = AppColors.text_dark,
    this.fontsize,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
   final double width;
   final double? fontsize;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child:  Row(
      
      
      children: <Widget>[
        
        Container(
          width: isSquare? size : 16,
          height: isSquare? size : 3,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.rectangle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: fontsize ?? 16,
            fontWeight: FontWeight.normal,
            color: textColor,
          ),
        )
      ],
    ),
    );
  }
}