import 'dart:math';

import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  GridItem({required this.title, required this.width, required this.height, required this.value, required this.icon});
  final double width;
  final double height;
  final int value;
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    
    return 
         Container(
          width: width,
          height: height,

         
           decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey, // Border color
                        width: 1.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(
                          8.0),
                      color: value ==0? Colors.transparent : Colors.red, // Optional: to give rounded corners
                    ),
         child:Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
      crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
          children: [
          Text(title, style: TextStyle( color:Colors.white, fontWeight: FontWeight.bold  ),),
          SizedBox(height: 10,),
          Icon(icon, color: Colors.white,size: 30,),
          SizedBox(height: 10,),
          Text(value ==0? 'Tắt':'Bật',style:  TextStyle( color:Colors.white, fontWeight: FontWeight.bold))
         ],) ,) 
        );
      
  }
}
