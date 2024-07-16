/// Flutter package imports
import 'package:flutter/material.dart';

/// Gauge imports
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Local imports



/// Renders the linear gauge thermometer sample.
class Thermometer extends StatefulWidget {
  /// Creates the linear gauge thermometer sample.
  const Thermometer({ required this.width, required this.height}) ;
  final double width;
  final double height;

  @override
  State<Thermometer> createState() => _ThermometerState();
}

/// State class of thermometer sample.
class _ThermometerState extends  State<Thermometer>  {
  double _meterValue = 60;
  final double _temperatureValue = 50;

  @override
  Widget build(BuildContext context) {
    return 
       _buildThermometer(context);
  }

  /// Returns the thermometer.
  Widget _buildThermometer(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final Brightness brightness = Theme.of(context).brightness;

    return Container(

      width: widget.width,
      height: widget.height,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        /// Linear gauge to display celsius scale.
                        SfLinearGauge(
                            minimum: 0,
                            maximum: 100,
                            interval: 100,
                            minorTicksPerInterval: 0,
                            axisTrackExtent: 23,
                            axisTrackStyle: LinearAxisTrackStyle(
                                thickness: 12,
                                color: Colors.transparent,
                                borderWidth: 1,
                                edgeStyle: LinearEdgeStyle.bothCurve),
                            tickPosition: LinearElementPosition.outside,
                            labelPosition: LinearLabelPosition.outside,
                            orientation: LinearGaugeOrientation.vertical,
                            markerPointers: <LinearMarkerPointer>[
                              LinearWidgetPointer(
                                  markerAlignment: LinearMarkerAlignment.end,
                                  value: 100,
                                  enableAnimation: false,
                                  position: LinearElementPosition.outside,
                                  offset: 8,
                                  child: SizedBox(
                                    height: 30,
                                    child: Text(
                                      '°C',
                                      style: TextStyle(
                                          fontSize:  12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  )),
                              LinearShapePointer(
                                value: 0,
                                markerAlignment: LinearMarkerAlignment.start,
                                shapeType: LinearShapePointerType.circle,
                                borderWidth: 1,
                                borderColor: brightness == Brightness.dark
                                    ? Colors.white30
                                    : Colors.black26,
                                color:Colors.white,
                                position: LinearElementPosition.cross,
                                width: 24,
                                height: 24,
                              ),
                              LinearShapePointer(
                                value: 0,
                                markerAlignment: LinearMarkerAlignment.start,
                                shapeType: LinearShapePointerType.circle,
                                borderWidth: 6,
                                borderColor: Colors.transparent,
                                color: _meterValue > _temperatureValue
                                    ? const Color(0xffFF7B7B)
                                    : const Color(0xff0074E3),
                                position: LinearElementPosition.cross,
                                width: 24,
                                height: 24,
                              ),
                              LinearWidgetPointer(
                                  value: 0,
                                  markerAlignment: LinearMarkerAlignment.start,
                                  child: Container(
                                    width: 10,
                                    height: 3.4,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                            width: 2.0,
                                            color: Colors.red),
                                        right: BorderSide(
                                            width: 2.0,
                                            color:Colors.blue),
                                      ),
                                      color: _meterValue > _temperatureValue
                                          ? const Color(0xffFF7B7B)
                                          : const Color(0xff0074E3),
                                    ),
                                  )),
                            
                              LinearShapePointer(
                                value: _meterValue,
                                width: 20,
                                height: 20,
                                enableAnimation: false,
                                color: Colors.transparent,
                                position: LinearElementPosition.cross,
                                onChanged: (dynamic value) {
                                  setState(() {
                                    _meterValue = value as double;
                                  });
                                },
                              )
                            ],
                            barPointers: <LinearBarPointer>[
                              LinearBarPointer(
                                value: _meterValue,
                                enableAnimation: false,
                                thickness: 6,
                                edgeStyle: LinearEdgeStyle.endCurve,
                                color: _meterValue > _temperatureValue
                                    ? const Color(0xffFF7B7B)
                                    : const Color(0xff0074E3),
                              )
                            ]),

                        /// Linear gauge to display Fahrenheit  scale.
                        
                      ],
                    ));
  }
}