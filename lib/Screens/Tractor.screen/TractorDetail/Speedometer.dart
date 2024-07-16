import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../values/app_colors.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
final url = dotenv.env['BASE_URL'];
class Speedometer1 extends StatefulWidget {
  Speedometer1({required this.tractorId, required this.token});
  final String tractorId;
  final String token;

  @override
  _SpeedState createState() => _SpeedState();
}

class _SpeedState extends State<Speedometer1> {
  late IO.Socket socket;
  double speed = 0;
  void labelCreated(AxisLabelCreatedArgs args) {
    if (args.text == '0') {
      args.text = 'N';
      args.labelStyle = GaugeTextStyle(
          color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14);
    } else if (args.text == '10')
      args.text = '';
    else if (args.text == '20')
      args.text = 'E';
    else if (args.text == '30')
      args.text = '';
    else if (args.text == '40')
      args.text = 'S';
    else if (args.text == '50')
      args.text = '';
    else if (args.text == '60')
      args.text = 'W';
    else if (args.text == '70') args.text = '';
  }

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
        final _speed = b['ctr_fed'][15];
        if (speed != _speed) {
          setState(() {
            speed = _speed;
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(startAngle: 270, endAngle: 270,minimum: 0,maximum: 80,interval: 10,radiusFactor: 0.4,
              showAxisLine: false, showLastLabel: false, minorTicksPerInterval: 4,
      majorTickStyle: MajorTickStyle(length: 8,thickness: 3,color: AppColors.textColor),
      minorTickStyle: MinorTickStyle(length: 3,thickness: 1.5,color: AppColors.textColor),
      axisLabelStyle: GaugeTextStyle(color: AppColors.textColor,fontWeight: FontWeight.bold,fontSize: 14 ),
      onLabelCreated: labelCreated),
  

            RadialAxis(
              minimum: 0,
              maximum: 60,
              labelOffset: 10,
              axisLineStyle: AxisLineStyle(
                  thicknessUnit: GaugeSizeUnit.factor, thickness: 0.03),
              majorTickStyle:
                  MajorTickStyle(length: 6, thickness: 3, color: AppColors.textColor),
              minorTickStyle:
                  MinorTickStyle(length: 3, thickness: 2, color: AppColors.textColor),
              axisLabelStyle: GaugeTextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
              ranges: <GaugeRange>[
                GaugeRange(
                    startValue: 0,
                    endValue: 200,
                    sizeUnit: GaugeSizeUnit.factor,
                    startWidth: 0.03,
                    endWidth: 0.03,
                    gradient: SweepGradient(colors: const <Color>[
                      Colors.green,
                      Colors.yellow,
                      Colors.red
                    ], stops: const <double>[
                      0.0,
                      0.5,
                      1
                    ]))
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                    value: speed,
                    needleLength: 0.95,
                    enableAnimation: true,
                    animationType: AnimationType.ease,
                    needleStartWidth: 1.5,
                    needleEndWidth: 6,
                    needleColor: Colors.red,
                    knobStyle: KnobStyle(knobRadius: 0.09, color: AppColors.textColor))
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Container(
                        child: Column(children: <Widget>[
                      Text(speed.toString(),
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor)),
                      SizedBox(height: 20),
                      Text('Tốc độ (km/h)',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor))
                    ])),
                    angle: 90,
                    positionFactor: 1.5)
              ],
            ),
          ],
        )
      ],
    );
  }
}
