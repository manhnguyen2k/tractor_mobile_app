import 'package:flutter/material.dart';

class Battery extends StatelessWidget{
  Battery({required this.percent});
  final int percent;
  @override
   Widget build(BuildContext context) {
    String imagePath;
    if (percent >=0 && percent <= 20) {
      imagePath = 'assets/image/battery_1.png';
    } else if (percent >20 && percent <= 40) {
      imagePath = 'assets/image/battery_2.png';
    } else if (percent >40 && percent <= 60) {
      imagePath = 'assets/image/battery_3.png';
    } 
    else if (percent >60 && percent <= 80) {
      imagePath = 'assets/image/battery_4.png';
    } 
    else {
      imagePath = 'assets/image/battery_5.png';
    }

    return Image.asset(
      imagePath,
      width: 50,
      height: 40,
    );
  }
}