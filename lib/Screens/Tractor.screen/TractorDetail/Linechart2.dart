//import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import './wigets/indicator.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../values/app_colors.dart';
final url = dotenv.env['BASE_URL'];
class LineChart2 extends StatefulWidget {
  LineChart2({
    required this.tractorId,
    required this.token
  });
  final String tractorId;
  final String token;
  @override
  _LineChartState createState()=>_LineChartState();
 
 

 
}
class _LineChartState extends State<LineChart2>{
  late IO.Socket socket;
  List<FlSpot> dataPoints1 = [FlSpot(0, 0)];
  List<FlSpot> dataPoints2 = [FlSpot(0, 0)];
  List<FlSpot> dataPoints3 = [FlSpot(0, 0)];
  late int now1;
  late int now2;
  late int now3;
  int maxLength = 30;
  void connect( IO.Socket socket) async {
   if(socket.disconnected){
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
      if (this.mounted) {
        setState(() {
          now1 += 1;
          now2 += 1;
          now3 += 1;
          final newSpot1 = FlSpot(now1.toDouble(), b['ypr'][0].toDouble());
          final newSpot2 = FlSpot(now2.toDouble(), b['ypr'][1].toDouble());
          final newSpot3 = FlSpot(now3.toDouble(), b['ypr'][2].toDouble());
          // print('newwwwwwwwwwwwwwwwwwwwww: $newSpot');
          // print('now: $now');
     
          if (dataPoints1.length >= maxLength) {
            dataPoints1.removeAt(0);
            now1 -= 1;
            for (int i = 0; i < dataPoints1.length; i++) {
              dataPoints1[i] = FlSpot(
                  i.toDouble(),
                  dataPoints1[i]
                      .y); // Cập nhật chỉ số `x` từ 0 đến `dataPoints.length - 1`
            }
          }
           if (dataPoints2.length >= maxLength) {
            dataPoints2.removeAt(0);
            now2 -= 1;
            for (int i = 0; i < dataPoints2.length; i++) {
              dataPoints2[i] = FlSpot(
                  i.toDouble(),
                  dataPoints2[i]
                      .y); // Cập nhật chỉ số `x` từ 0 đến `dataPoints.length - 1`
            }
          }
          if (dataPoints3.length >= maxLength) {
            dataPoints3.removeAt(0);
            now3 -= 1;
            for (int i = 0; i < dataPoints3.length; i++) {
              dataPoints3[i] = FlSpot(
                  i.toDouble(),
                  dataPoints3[i]
                      .y); // Cập nhật chỉ số `x` từ 0 đến `dataPoints.length - 1`
            }
          }

          dataPoints1.add(newSpot1);
           dataPoints2.add(newSpot2);
           dataPoints3.add(newSpot3);
        });
      }

        print(dataPoints1);
    });

   }
  
  
  }
  @override
    void initState(){
      super.initState();
         now1 = 0;
    now2 = 0;
    now3 = 0;
     Map<String, String> extraHeaders = {
    'token':
             widget.token
  };

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
   
   socket.onDisconnect( (_) {
    print('DisConnected to the socket server');
  });
      socket.disconnect();

      socket.dispose();
    
    
    
    super.dispose();
  }
   @override
  Widget build(BuildContext context) {
    return 
      
   AspectRatio(
    aspectRatio: 1.50,
    child: Column(
    //  crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 2,
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      
       const Column(
          mainAxisAlignment: MainAxisAlignment.start, // Align at the top of the Column
          crossAxisAlignment: CrossAxisAlignment.center, // Align at the center horizontally
          children: const [
            Indicator(
              color: Colors.green,
              text: 'Góc chúc - Yaw',
              isSquare: false,
              width: 200,
            ),
            SizedBox(
              height: 4,
            ),
            Indicator(
              color: Colors.pink,
              text: 'Góc nghiêng - Pitch',
              isSquare: false,
              width: 200,
            ),
            SizedBox(
              height: 4,
            ),
            Indicator(
              color: Colors.orange,
              text: 'Góc xoay - Roll',
              isSquare: false,
              width: 200,
            ),
          ],
        ),
      ],
    ),
  );

  }

  LineChartData mainData() {
    return LineChartData(
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      titlesData: FlTitlesData(  topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                           value.toInt().toString(),
                          style: TextStyle(
                            color: AppColors.text_dark, // Chỉnh màu chữ của title
                            
                          ),
                        );
                      },
                    ),
                  ),
                   leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                           value.toInt().toString(),
                          style: TextStyle(
                            color: AppColors.text_dark, // Chỉnh màu chữ của title
                            fontSize: 12
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                           value.toInt().toString(),
                          style: TextStyle(
                            color: AppColors.text_dark, // Chỉnh màu chữ của title
                            fontSize: 12
                          ),
                        );
                      },
                    ),
                  ),
                  ),
      minX: 0,
      maxX: 30,
      minY: 0,
      maxY: 360,
      lineBarsData: [
        LineChartBarData(
          
          spots: dataPoints1,
          isCurved: true,
         color: Colors.green,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          
          
        ),
         LineChartBarData(
          spots: dataPoints2,
          isCurved: true,
          color: Colors.pink,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          
        ),
         LineChartBarData(
          spots: dataPoints3,
          isCurved: true,
          color: Colors.orange,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          
        ),
        
      ],
    );
  }
}
