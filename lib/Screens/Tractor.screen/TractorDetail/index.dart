import 'package:flutter/material.dart';
import '../../../values/app_colors.dart';
import 'Linechart.dart';
import './wigets/Piechart.dart';
import 'Linechart2.dart';
import 'Speedometer.dart';

class TractorDetailChart extends StatefulWidget {
  TractorDetailChart({required this.tractorId, required this.token});
  final String tractorId;
final String token;
  @override
  State<TractorDetailChart> createState() => _TractorDetailChart();
}

class _TractorDetailChart extends State<TractorDetailChart> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.darkBlue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.grey),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Máy cày đang online:',
            style: TextStyle(
                color: Colors.grey, // Set the text color here
                fontSize: 24.0, // Set the font size here
                fontWeight: FontWeight.normal),
          ),
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(
                5.0), // Increase vertical padding for more spacing
            child: Container(
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 1.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(
                      8.0), // Optional: to give rounded corners
                ),
                child: Expanded(
                  child: LineChart1(tractorId: widget.tractorId, token: widget.token,),
                )),
          ),
          Container(
               padding: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white, width: 1),),
                ),
              child:Row(         
              children: [
                  Expanded(
                    child:
                      Container(
                        height: 200,
                        child: PieChartSample2(tractorId: widget.tractorId,token: widget.token,logItem: 'sum',logItemIndex1: 2,logItemIndex2: 3,), 
                      )
                    ),
                    Expanded(
                    child:
                      Container(
                        height: 200,
                        child: PieChartSample2(tractorId: widget.tractorId,token: widget.token,logItem: 'sum',logItemIndex1: 0,logItemIndex2: 1,item1_color: Colors.red,item1_name: 'Thời gian đã đi',item2_color: Colors.orange,item2_name: 'Thời gian còn lại',), 
                      )
                    )
                  ]
              
            ) ,
            ),
           Padding(
            padding: const EdgeInsets.all(
                5.0), // Increase vertical padding for more spacing
            child: Container(
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 1.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(
                      8.0), // Optional: to give rounded corners
                ),
                child: Expanded(
                  child: LineChart2(tractorId: widget.tractorId, token: widget.token,),
                )),
          ),
           Padding(
            padding: const EdgeInsets.all(
                5.0), // Increase vertical padding for more spacing
            child: Container(
                height: 500,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey, // Border color
                    width: 1.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(
                      8.0), // Optional: to give rounded corners
                ),
                child: Expanded(
                  child: Speedometer1(tractorId: widget.tractorId, token: widget.token,),
                )),
          ),
        ]));
    throw UnimplementedError();
  }
}
