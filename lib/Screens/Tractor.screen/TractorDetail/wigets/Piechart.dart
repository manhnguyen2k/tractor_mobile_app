
//import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:fl_chart/fl_chart.dart';
import './indicator.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
final url = dotenv.env['BASE_URL'];
class PieChartSample2 extends StatefulWidget {
 // const PieChartSample2({super.key});
  PieChartSample2({
    required this.tractorId, 
     required this.token, 
    required this.logItem,
    required this.logItemIndex1,
    required this.logItemIndex2,
    this.item1_name, 
    this.item2_name,
    this.item1_color,
    this.item2_color,
    });
  final String tractorId;
  final String token;
  final String logItem;
  final int logItemIndex1;
  final int logItemIndex2;
  final String? item1_name;
  final String? item2_name;
  final Color? item1_color;
  final Color? item2_color;

  @override
  PieChart2State createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;
  double sections1 = 50;
  double sections2 = 50;
  late IO.Socket socket;
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
      final Map<String, dynamic> b = jsonDecode(data['logs']);
    
      final double _sections1 = b[widget.logItem][widget.logItemIndex1].toDouble();
      final double _sections2 = b[widget.logItem][widget.logItemIndex2].toDouble();
        final sum = _sections2+_sections1;
        final percent1 = (_sections1/sum)*100;
        final percent2 = (_sections2/sum)*100;
      if(mounted){
        setState(() {
          sections1 = percent1;
          sections2 = percent2;
        });
      }

    });

   }
   
  
  }
  @override
  void initState(){
    super.initState();
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
  void dispose(){
    socket.onDisconnect( (_) {
    print('DisConnected to the socket server');
  });
      socket.disconnect();

      socket.dispose();
    
    
    
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
 
    return  AspectRatio(
      aspectRatio: 1.4,
      child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                   startDegreeOffset: -90,
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: true,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 20,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
           Indicator(
                color: widget.item1_color?? Colors.blue,
                text: widget.item1_name ??'Quãng đường đã đi',
                isSquare: true,
                width: 137,
                fontsize: 12,
              ),
          const   SizedBox(
                height: 4,
              ),
            
              Indicator(
                color: widget.item2_color??Colors.green,
                text: widget.item2_name ??'Quãng đường còn lại',
                isSquare: true,
                width: 137,
                fontsize: 12,
              ),
            
        
         
          
          
        ],
      ),
    );
    
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: widget.item1_color?? Colors.blue,
            value: sections2,
            title: '${sections2.toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
       
        case 1:
          return PieChartSectionData(
            color:widget.item2_color?? Colors.green,
            value: sections1,
            title: '${sections1.toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color:Colors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
