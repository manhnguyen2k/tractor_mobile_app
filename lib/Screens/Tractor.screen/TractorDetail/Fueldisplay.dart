import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../../values/app_colors.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
final url = dotenv.env['BASE_URL'];
class FuelDisplay extends StatefulWidget{
  FuelDisplay({required this.tractorId, required this.token});
  final String tractorId;
  final String token;
  @override
 State<FuelDisplay> createState()=>_FuelDiaplayState();
}
class _FuelDiaplayState extends State<FuelDisplay>{
late IO.Socket socket;
 double fuel = 0;
  void connect(IO.Socket socket) async {
    if (socket.disconnected) {
      print('before: ${socket.disconnected}');

      socket.onConnect((_) {
        print('connect11111');

        //socket.emit('msg', 'test');
      });
      socket.connect();

      // Wait until the completer is marked as complete

      print('after: ${socket.disconnected}');
      socket.on(widget.tractorId, (data) {
        // print('---------------------------mount Chart update');
        //  print('tttttttttttttttt');
        final Map<String, dynamic> b = jsonDecode(data['logs']);
        final _fuel = b['sen'][1];
        if (fuel != _fuel) {
          setState(() {
            fuel = _fuel;
          });
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    Map<String, String> extraHeaders = {'token': widget.token};

    // Khởi tạo kết nối socket với headers
    socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'force new connection': true,
      'extraHeaders': extraHeaders,
    });

    connect(socket);
  }

  @override
  void dispose() {
    print('---------------------------UNmount CHarT');
    // socket.off('64d9cdfac48bca2dd296ad1d'); // Dispose the socket connection

    socket.onDisconnect((_) {
      print('DisConnected to the socket server');
    });
    socket.disconnect();

    socket.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
     // height: 300,
      child: Center(
        child: SfRadialGauge(
    
      
          axes: <RadialAxis>[
            RadialAxis(
                startAngle: 225,
                endAngle: 0,
                showTicks: false,
                showAxisLine: false,
                showLabels: false,
                //canScaleToFit: true,
                 annotations: <GaugeAnnotation>[
                  
                  GaugeAnnotation(
                      widget: Text(
                        'E',
                        style: TextStyle(
                          color: AppColors.textColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Times'),
                      ),
                      angle: 215,
                      positionFactor: 1),
                  GaugeAnnotation(
                      widget: Text(
                        'F',
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Times'),
                      ),
                      angle: 10,
                      positionFactor: 0.95),
                        GaugeAnnotation(
                    widget: Container(
                        child: Column(children: <Widget>[
                      Text('${fuel.toInt().toString()}%',
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor)),
                     
                      Text('Nhiên liệu',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor))
                    ])),
                    angle: 90,
                    positionFactor: 1.1)
                ],
                ranges: <GaugeRange>[
                  GaugeRange(
                      startValue: 0,
                      endValue: 20,
                      startWidth: 10,
                      endWidth: 15,
                      color: Colors.red),
                
                  GaugeRange(
                      startValue: 22,
                      endValue: 40,
                      startWidth: 15,
                      endWidth: 20,
                      color: AppColors.textColor),
               
                  GaugeRange(
                      startValue: 42,
                      endValue: 60,
                      startWidth: 20,
                      endWidth: 25,
                      color: AppColors.textColor),
                 
                  GaugeRange(
                      startValue: 62,
                      endValue: 80,
                      startWidth: 25,
                      endWidth: 30,
                      color: AppColors.textColor),
                
                  GaugeRange(
                      startValue: 82,
                      endValue: 100,
                      startWidth: 30,
                      endWidth: 35,
                      color: AppColors.textColor),
                
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(
                      value: fuel,
                      needleEndWidth: 7,
                     // onValueChanged: _onPointerValueChanged,
                      needleStartWidth: 1,
                      needleColor: Colors.red,
                      needleLength: 0.8,
                      knobStyle:
                          KnobStyle(color: AppColors.textColor, knobRadius: 0.06))
                ],
               )
          ],
        ) ,
      )
       

      );  
  }
}