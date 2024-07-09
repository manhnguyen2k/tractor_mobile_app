import 'package:flutter/material.dart';
import 'dart:developer';
import 'Fueldisplay.dart';
import 'Progress.dart';
import 'Speedometer.dart';
import 'Icontractor.dart';
import 'Battery.dart';
import '../../values/app_routes.dart';
import '../../utils/helpers/navigation_helper.dart';
import './TractorDetail/index.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'dart:developer';
class Tractor_line extends StatefulWidget {
  Tractor_line({required this.tractorId, required this.token});
  final String tractorId;
 final String token;
  @override
  State<Tractor_line> createState() => _Tractor_lineState();
}

class _Tractor_lineState extends State<Tractor_line> {

 late IO.Socket socket3;
  int percent = 0;
  int err_count = 0;
  double feulpercent = 0.0;
  double speed = 0.0;
  double progress = 0.0;
  String tractorname = '';
  String tractorid = '';
  late Map<String, dynamic> Log = {};
  
   void connect(IO.Socket socket) async {
    print('eeeeeeeeeeeeee');
    if (socket.disconnected) {
      socket.connect();

      // Wait until the completer is marked as complete

      socket.on(widget.tractorId, (data) {
        // print('---------------------------mount Chart update');
        //  print('tttttttttttttttt');

        
      final Map<String, dynamic> b = jsonDecode(data['logs']);
      final power = b['sen'][0];
      final fuel = b['sen'][1];
      final double _sections1 = b['sum'][2].toDouble();
      final double _sections2 = b['sum'][3].toDouble();
        final sum = _sections2+_sections1;
        final percent1 = (_sections1/sum)*100;
      //  final percent2 = (_sections2/sum)*100;
      final _speed = b['ctr_fed'][15];
      final _error_count = b['err'].length;
      final _tractorname = b['id'][1];
      final _tractorid = b['id'][0];
      if(tractorid !=_tractorid){
        setState(() {
           tractorid = _tractorid;
        });
      }
      if(tractorname !=_tractorname){
        setState(() {
           tractorname = _tractorname;
        });
      }
      if(percent !=power){
        setState(() {
           percent = power;
        });
      }
      if(feulpercent !=fuel){
        setState(() {
           feulpercent = fuel;
        });
      }
      if(speed !=_speed){
        setState(() {
           speed = _speed;
        });
      }
       if(err_count !=_error_count){
        setState(() {
           err_count = _error_count;
        });
      }
       if(err_count !=_error_count){
        setState(() {
           err_count = _error_count;
        });
      }
      if(progress!= percent1){
        setState(() {
          progress=percent1;
        });
      }

        // print(dataPoints);
      });
    }
  }
  @override
  void initState() {
    super.initState();
     log(widget.tractorId);
     Map<String, String> extraHeaders = {
      'token': widget.token
         
    };

    socket3 = IO.io('http://tractorserver.myddns.me:3001', <String, dynamic>{
      'transports': ['websocket'],
      'force new connection': true,
      'extraHeaders': extraHeaders,
    });

    connect(socket3);
  }

  @override
  void dispose() {
    socket3.onDisconnect( (_) {
    print('DisConnected to the socket server');
  });
      socket3.disconnect();

      socket3.dispose();
    
    
    
    super.dispose();
  
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.only(left: 10.0, ), // Add vertical padding for spacing
            child: 
            Row(
               mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: 70,
            width:  60,
          child: Column(children: [Icontractor(),Text(tractorname)],) ,
        ),
        const SizedBox(
          width: 10
        ),
        Container(
          width: 70,
          height: 70,
          child: Column(
            children: [ Progress(progress: progress ,),Text('Tiến độ')],
          )
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          width: 70,
          height: 70,
          child: Column(
            children: [Fueldisplay(fuelvalue: feulpercent,),Text('Nhiên liệu')],
          ) 
        ),
        const SizedBox(
          width: 10
        ),
        Container(
          width: 50,
          height: 70,
          child: Column(
           //  crossAxisAlignment: CrossAxisAlignment.center,
            children:  [Battery(percent: percent,),SizedBox(height: 10,),Text('Pin')],
            ),
        ),
        const SizedBox(
          width: 15,
        ),
        Container(
          width: 50,
          height: 70,
          child: Column(children: [Speedometer(speed: speed,),Text('Tốc độ')],) ,
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () =>{ Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TractorDetailChart(tractorId: tractorid,token: widget.token,)),
              ),},
                
          child: Image.asset(
            'assets/image/menu.png', width: 30, // Chỉnh độ rộng của ảnh
            height: 50,
          ),
        ),
      ],
    )
          ); 
  }
}
