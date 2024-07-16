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
   // log(widget.progress.toString());
    // TODO: implement buildretu
    return Container(
   
      height: 50,
      child: LinearPercentIndicator(
              //  width: 140.0,
                lineHeight: 14.0,
                barRadius: Radius.circular(3),
                percent: 0.5,
                backgroundColor: Colors.grey,
                progressColor: AppColors.primaryColor,
              ),
    ); 
    throw UnimplementedError();
  }
}