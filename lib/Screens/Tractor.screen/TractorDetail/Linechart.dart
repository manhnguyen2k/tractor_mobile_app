import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import './wigets/indicator.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
final url = dotenv.env['BASE_URL'];
final int maxLength = 30;

class LineChart1 extends StatefulWidget {
  LineChart1({required this.tractorId, required this.token});
  final String tractorId;
  final String token;
  @override
  State<LineChart1> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChart1> {
  List<Color> gradientColors = [
    Colors.white,
    Colors.blue,
  ];
  List<Color> gradientColors1 = [
    Color.fromARGB(255, 188, 156, 156),
    Color.fromARGB(255, 227, 224, 159),
  ];
  
  late int now;
  late int now1;
  late List<FlSpot> point;
  List<FlSpot> dataPoints = [FlSpot(0, 0)];
  List<FlSpot> dataPoints1 = [FlSpot(0, 0)];
  late IO.Socket socket;
   final Completer<void> completer = Completer<void>();
  void connect( IO.Socket socket) async {
   if(socket.disconnected){
  print('before: ${socket.disconnected}');

    socket.onConnect((_) {
      print('connect11111');
      completer.complete();
      //socket.emit('msg', 'test');
    });
    socket.connect();

    await completer.future; // Wait until the completer is marked as complete

    print('after: ${socket.disconnected}');
    socket.on(widget.tractorId, (data) {
      // print('---------------------------mount Chart update');
      //  print('tttttttttttttttt');
      final Map<String, dynamic> b = jsonDecode(data['logs']);
      if (this.mounted) {
        setState(() {
          now += 1;
          now1 += 1;
          final newSpot = FlSpot(now.toDouble(), b['ctr_fed'][10].toDouble());
          final newSpot1 = FlSpot(now.toDouble(), b['ctr_fed'][11].toDouble());
          // print('newwwwwwwwwwwwwwwwwwwwww: $newSpot');
          // print('now: $now');
     
          if (dataPoints.length >= maxLength) {
            dataPoints.removeAt(0);
            now -= 1;
            for (int i = 0; i < dataPoints.length; i++) {
              dataPoints[i] = FlSpot(
                  i.toDouble(),
                  dataPoints[i]
                      .y); // Cập nhật chỉ số `x` từ 0 đến `dataPoints.length - 1`
            }
          }
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

          dataPoints.add(newSpot);
           dataPoints1.add(newSpot1);
        });
      }

       //print(dataPoints);
    });

   }
   
  
  }



  @override
  void initState() {
   
    super.initState();
    now = 0;
    now1 = 0;
     Map<String, String> extraHeaders = {
    'token':widget.token
              
        
  };

  // Khởi tạo kết nối socket với headers
   socket = IO.io(url, <String, dynamic>{
    'transports': ['websocket'],
    'force new connection': true,
    'extraHeaders': extraHeaders,
  });

    connect(socket);
    // if (!mounted) return;
   // print(socket.connected);
    //dataPoints.add(FlSpot(now.toDouble(), 0.0));
  }

  /*
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //int newnow = now+1;
      now += 1 ;
     
       
      print('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb$dataPoints');
  }
*/
  @override
  void dispose() {
    log('---------------------------UNmount CHarT');
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
       const SizedBox(height: 15),
       const Column(
          mainAxisAlignment: MainAxisAlignment.start, // Align at the top of the Column
          crossAxisAlignment: CrossAxisAlignment.center, // Align at the center horizontally
          children: const [
            Indicator(
              color: Colors.blue,
              text: 'Độ nghiêng dàn xới mong muốn',
              isSquare: false,
              width: 270,
            ),
            SizedBox(
              height: 4,
            ),
            Indicator(
              color: Color.fromARGB(255, 227, 224, 159),
              text: 'Độ nghiêng dàn xới thực tế',
              isSquare: false,
              width: 270,
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
                            color: Colors.white, // Chỉnh màu chữ của title
                            
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
                            color: Colors.white, // Chỉnh màu chữ của title
                            fontSize: 16
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
                            color: Colors.white, // Chỉnh màu chữ của title
                            fontSize: 16
                          ),
                        );
                      },
                    ),
                  ),
                  ),
      minX: 0,
      maxX: 30,
      minY: 0,
      maxY: 50,
      lineBarsData: [
        LineChartBarData(
          
          spots: dataPoints,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
         LineChartBarData(
          spots: dataPoints1,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors1,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors1
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
        
      ],
    );
  }
}
