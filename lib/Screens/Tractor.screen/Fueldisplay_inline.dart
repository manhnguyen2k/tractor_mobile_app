import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Fueldisplay extends StatefulWidget {
  Fueldisplay({Key? key, required this.fuelvalue}) : super(key: key);
  final double fuelvalue;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

 

  @override
  _Fueldisplay createState() => _Fueldisplay();
}

class _Fueldisplay extends State<Fueldisplay> {
  @override
  Widget build(BuildContext context) {
    final Color dotColor;
    final theme = Theme.of(context);
    switch (theme.brightness) {
      case Brightness.light:
          dotColor = Colors.black;
      case Brightness.dark:
          dotColor = Colors.grey;
        
        break;
      default:  dotColor = Colors.white;
    }
    final card_color = theme.cardColor;
    return Container(
      height: 50,
      child:SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
                startAngle: 225,
                endAngle: 0,
                showTicks: false,
                showAxisLine: false,
                showLabels: false,
                canScaleToFit: true,
                ranges: <GaugeRange>[
                  GaugeRange(
                      startValue: 0,
                      endValue: 20,
                      startWidth: 2,
                      endWidth: 3,
                      color: Colors.red),
                
                  GaugeRange(
                      startValue: 22,
                      endValue: 40,
                      startWidth: 3,
                      endWidth: 4,
                      color: dotColor),
                
                  GaugeRange(
                      startValue: 42,
                      endValue: 60,
                      startWidth: 4,
                      endWidth: 5,
                      color: dotColor),
                  
                  GaugeRange(
                      startValue: 62,
                      endValue: 80,
                      startWidth: 5,
                      endWidth: 6,
                      color: dotColor),
                 
                  GaugeRange(
                      startValue: 82,
                      endValue: 100,
                      startWidth: 6,
                      endWidth: 7,
                      color: dotColor),
                  
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(
                      value: widget.fuelvalue,
                      needleEndWidth: 2,
                      //onValueChanged: _onPointerValueChanged(dotColor),
                      needleStartWidth: 1,
                      needleColor: Colors.red,
                      needleLength: 0.85,
                      knobStyle:
                          KnobStyle(color: dotColor, knobRadius: 0.09))
                ],
               )
          ],
        ) ,
    );  
      
  }

 
}