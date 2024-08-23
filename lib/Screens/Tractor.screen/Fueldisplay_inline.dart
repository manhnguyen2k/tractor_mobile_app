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
                      color: _color1),
                
                  GaugeRange(
                      startValue: 22,
                      endValue: 40,
                      startWidth: 3,
                      endWidth: 4,
                      color: _color3),
                
                  GaugeRange(
                      startValue: 42,
                      endValue: 60,
                      startWidth: 4,
                      endWidth: 5,
                      color: _color5),
                  
                  GaugeRange(
                      startValue: 62,
                      endValue: 80,
                      startWidth: 5,
                      endWidth: 6,
                      color: _color7),
                 
                  GaugeRange(
                      startValue: 82,
                      endValue: 100,
                      startWidth: 6,
                      endWidth: 7,
                      color: _color9),
                  
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(
                      value: widget.fuelvalue,
                      needleEndWidth: 2,
                      onValueChanged: _onPointerValueChanged,
                      needleStartWidth: 1,
                      needleColor: Colors.red,
                      needleLength: 0.85,
                      knobStyle:
                          KnobStyle(color: Colors.black, knobRadius: 0.09))
                ],
               )
          ],
        ) ,
    );  
      
  }

  void _onPointerValueChanged(double _value) {
    setState(() {
      if (_value >= 0 && _value <= 10) {
        _onFirstRangeColorChanged();
      } else if (_value >= 10 && _value <= 20) {
        _onSecondRangeColorChanged();
      } else if (_value >= 20 && _value <= 30) {
        _onThirdRangeColorChanged();
      } else if (_value >= 30 && _value <= 40) {
        _onFourthRangeColorChanged();
      } else if (_value >= 40 && _value <= 50) {
        _onFifthRangeColorChanged();
      } else if (_value >= 50 && _value <= 60) {
        _onSixthRangeColorChanged();
      } else if (_value >= 60 && _value <= 70) {
        _onSeventhRangeColorChanged();
      } else if (_value >= 70 && _value <= 80) {
        _onEighthRangeColorChanged();
      } else if (_value >= 80 && _value <= 90) {
        _onNinethRangeColorChanged();
      } else if (_value >= 90 && _value <= 100) {
        _onTenthRangeColorChanged();
      }
    });
  }

  void _onFirstRangeColorChanged() {
    _color1 = Colors.red;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.black;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onSecondRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.red;
    _color3 = Colors.black;
    _color4 = Colors.black;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onThirdRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.red;
    _color4 = Colors.black;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onFourthRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.red;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onFifthRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.black;
    _color5 = Colors.red;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onSixthRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.black;
    _color5 = Colors.black;
    _color6 = Colors.red;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onSeventhRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.black;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.red;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onEighthRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.black;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.red;
    _color9 = Colors.black;
    _color10 = Colors.black;
  }

  void _onNinethRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.black;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.red;
    _color10 = Colors.black;
  }

  void _onTenthRangeColorChanged() {
    _color1 = Colors.black;
    _color2 = Colors.black;
    _color3 = Colors.black;
    _color4 = Colors.red;
    _color5 = Colors.black;
    _color6 = Colors.black;
    _color7 = Colors.black;
    _color8 = Colors.black;
    _color9 = Colors.black;
    _color10 = Colors.red;
  }

  Color _color1 = Colors.red;
  Color _color2 = Colors.black;
  Color _color3 = Colors.black;
  Color _color4 = Colors.black;
  Color _color5 = Colors.black;
  Color _color6 = Colors.black;
  Color _color7 = Colors.black;
  Color _color8 = Colors.black;
  Color _color9 = Colors.black;
  Color _color10 = Colors.black;
}