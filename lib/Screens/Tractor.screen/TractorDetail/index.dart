import 'package:flutter/material.dart';
import '../../../values/app_colors.dart';
import 'Linechart.dart';
import './wigets/Piechart.dart';
import 'Linechart2.dart';
import 'Speedometer.dart';
import 'Fueldisplay.dart';
import 'List_grid.dart';
import '../../../utils/common_widgets/appbar.dart';

class TractorDetailChart extends StatefulWidget {
  TractorDetailChart(
      {required this.tractorId,
      required this.token,
      required this.tractorName});
  final String tractorId;
  final String token;
  final String tractorName;
  @override
  State<TractorDetailChart> createState() => _TractorDetailChart();
}

class _TractorDetailChart extends State<TractorDetailChart> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: CustomAppBar(
          title: widget.tractorName,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(
                  15.0), // Increase vertical padding for more spacing
              child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: AppColors.cardBackgroundColor,

                    borderRadius: BorderRadius.circular(
                        8.0), // Optional: to give rounded corners
                  ),
                  child:
                   Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                    child: LineChart1(
                      tractorId: widget.tractorId,
                      token: widget.token,
                    ),
                  ) ,)
                  ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       Container(
                         decoration: BoxDecoration(
                    color: AppColors.cardBackgroundColor,
                    borderRadius:
                        BorderRadius.circular(8.0), // Optional: to give rounde
                  ),
                     height: 300,
                     
                        child: PieChartSample2(
                          tractorId: widget.tractorId,
                          token: widget.token,
                          logItem: 'sum',
                          logItemIndex1: 2,
                          logItemIndex2: 3,
                        ),
                      ),
                     
                          Container(
                            decoration: BoxDecoration(
                    color: AppColors.cardBackgroundColor,
                    borderRadius:
                        BorderRadius.circular(8.0), // Optional: to give rounde
                  ),
                        height: 300,
                        child: PieChartSample2(
                          tractorId: widget.tractorId,
                          token: widget.token,
                          logItem: 'sum',
                          logItemIndex1: 0,
                          logItemIndex2: 1,
                          item1_color: Colors.red,
                          item1_name: 'Thời gian đã đi',
                          item2_color: Colors.orange,
                          item2_name: 'Thời gian còn lại',
                        ),
                      )
                    ]),
                  
            ),
            Padding(
              padding: const EdgeInsets.all(
                  5.0), // Increase vertical padding for more spacing
              child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: AppColors.cardBackgroundColor,
                    borderRadius: BorderRadius.circular(
                        8.0), // Optional: to give rounded corners
                  ),
                  child: Center(
                    child: LineChart2(
                      tractorId: widget.tractorId,
                      token: widget.token,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(
                  5.0), // Increase vertical padding for more spacing
              child: Container(
                  height: 380,
                  decoration: BoxDecoration(
                    color: AppColors.cardBackgroundColor,
                    borderRadius: BorderRadius.circular(
                        8.0), // Optional: to give rounded corners
                  ),
                  child: Center(
                    child: Speedometer1(
                      tractorId: widget.tractorId,
                      token: widget.token,
                    ),
                  )),
            ),
            Padding(
                padding: const EdgeInsets.all(
                    5.0), // Increase vertical padding for more spacing
                child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      color: AppColors.cardBackgroundColor,
                      borderRadius: BorderRadius.circular(
                          8.0), // Optional: to give rounded corners
                    ),
                    child: Center(
                      child: FuelDisplay(
                        tractorId: widget.tractorId,
                        token: widget.token,
                      ),
                    ))),
            Padding(
                padding: const EdgeInsets.all(
                    5.0), // Increase vertical padding for more spacing
                child: Container(
                    height: screenWidth,
                    //  width: 400,
                    decoration: BoxDecoration(
                      color: AppColors.cardBackgroundColor,
                      borderRadius: BorderRadius.circular(
                          8.0), // Optional: to give rounded corners
                    ),
                    child: ListGrid(
                      tractorId: widget.tractorId,
                      token: widget.token,
                    ))),
          ]),
        ));
  }
}
