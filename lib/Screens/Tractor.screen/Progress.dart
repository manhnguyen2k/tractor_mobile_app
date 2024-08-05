import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../values/app_colors.dart';
import 'dart:developer';
class Progress extends StatefulWidget{
  Progress({required this.progress});
  final double progress;
  @override
  State<Progress> createState()=>_ProgressState();
}
class _ProgressState extends State<Progress>{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: LinearPercentIndicator(
              //  width: 140.0,
                lineHeight: 14.0,
                barRadius: const Radius.circular(3),
                percent: widget.progress/100,
                backgroundColor: Colors.grey,
                progressColor: AppColors.primaryColor,
              ),
    ); 
  }
}