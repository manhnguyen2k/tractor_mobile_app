import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Speedometer extends StatefulWidget {
  Speedometer({required this.speed});
  final double speed;
  @override
  State<Speedometer> createState() => _SpeedometerState();
}

class _SpeedometerState extends State<Speedometer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: SfRadialGauge(
        axes: <RadialAxis>[
      RadialAxis(
        minimum: 0,
        maximum: 200,
        labelOffset: 30,
        axisLineStyle:
          const  AxisLineStyle(thicknessUnit: GaugeSizeUnit.factor, thickness: 0.03),
        majorTickStyle:
          const  MajorTickStyle(length: 4, thickness: 1, color: Colors.black),
        minorTickStyle:
          const  MinorTickStyle(length: 3, thickness: 1, color: Colors.black),
            showLabels:false,
        axisLabelStyle:const GaugeTextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14,),
        ranges: <GaugeRange>[
          GaugeRange(
              startValue: 0,
              endValue: 200,
              sizeUnit: GaugeSizeUnit.factor,
              startWidth: 0.1,
              endWidth: 0.1,
              gradient:const SweepGradient(colors:  <Color>[
                Colors.green,
                Colors.yellow,
                Colors.red
              ], stops: <double>[
                0.0,
                0.5,
                1
              ]))
        ],
        pointers: <GaugePointer>[
          NeedlePointer(
              value: widget.speed,
              needleLength: 0.9,
              enableAnimation: true,
              animationType: AnimationType.ease,
              needleStartWidth: 1,
              needleEndWidth: 2,
              needleColor: Colors.red,
              knobStyle:const KnobStyle(knobRadius: 0.09))
        ],
      ),
    ]),
    ) ;
  }
}
