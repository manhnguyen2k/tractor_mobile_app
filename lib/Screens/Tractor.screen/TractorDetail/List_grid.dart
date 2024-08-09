

import 'package:flutter/material.dart';
import 'Grid_Display.dart';
import 'Grid_item1.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../values/app_colors.dart';
final url = dotenv.env['BASE_URL'];
class ListGrid extends StatefulWidget{
  ListGrid({required this.tractorId, required this.token});
  final String tractorId;
  final String token;
  @override
  State<StatefulWidget> createState() => _ListGrid();
}
class _ListGrid extends State<ListGrid>{


late IO.Socket socket;
 double fuel = 0;
 int nguon = 0;
 int chuyen_mach = 0;
 int den_truoc = 0;
 int den_sau = 0;
 int de = 0;
 double nhiet_do_dong_co = 0;
 double nhiet_do_binh_dau = 0;
 double ap_suat = 0;
 double do_am = 0;

  void connect(IO.Socket socket) async {
    if (socket.disconnected) {
      socket.connect();
      socket.on(widget.tractorId, (data) {
        final Map<String, dynamic> b = jsonDecode(data['logs']);
        final _nguon= b['ctr_oly'][0];
        final _de =  b['ctr_oly'][1];
        final _chuyenmach =  b['ctr_oly'][2];
        final _den_truoc =  b['ctr_oly'][3];
        final _den_sau =  b['ctr_oly'][4];
        final _ap_suat =  b['sen'][9];
        final _nhiet_do_dong_co =  b['sen'][7];
         final _nhiet_do_nhien_lieu =  b['sen'][6];
         setState(() {
           nguon = _nguon.toInt();
           chuyen_mach = _chuyenmach.toInt();
           de = _de.toInt();
           den_sau= _den_truoc.toInt();
           den_sau = _den_sau.toInt();
           ap_suat = _ap_suat.toDouble();
           nhiet_do_binh_dau = _nhiet_do_nhien_lieu.toDouble();
           nhiet_do_dong_co = _nhiet_do_dong_co.toDouble();
         });
      });
    }
  }

  @override
  void initState() {
    super.initState();

    Map<String, String> extraHeaders = {'token': widget.token};
    socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'force new connection': true,
      'extraHeaders': extraHeaders,
    });

    connect(socket);
  }

  @override
  void dispose() {

    socket.disconnect();

    socket.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return(
      Container(
        child: LayoutBuilder(
            builder: (context, constraints) {
              // Adjust the size of the Container based on the parent constraints
              double width = constraints.maxWidth;
              double height = constraints.maxHeight;
              double item_width = width*0.32;
              double item_height = height*0.32;
              return Container(
                width: width,
                height: height,
                color: AppColors.backgroundColor,
                child:  Padding(
        padding: const EdgeInsets.all( 00),
        child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         GridItem(width: item_width, height: item_height,title: 'Nguồn', value: nguon,icon: Icons.settings_power_outlined,),  
                        GridItem(width: item_width, height: item_height,title: 'Chuyển nguồn', value: chuyen_mach,icon:  Icons.cached_sharp,), 
                        
                        GridItem(width: item_width, height: item_height,title: 'Đề', value: de,icon: Icons.flash_on_sharp,), 
                       
                      ],
                    ),
                    
                  Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GridItem(width: item_width, height: item_height,title: 'Đèn trước', value: den_truoc,icon: Icons.light,),
                         GridItem(width: item_width, height: item_height,title: 'Đèn sau', value: den_sau,icon: Icons.light,),  
                        GridItem1(title: 'Nhiệt độ động cơ', width: item_width, height: item_height, value: nhiet_do_dong_co, icon: Icons.thermostat_outlined)
                        
                       
                      ],
                    ),
                   
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        
                        GridItem1(title: 'Nhiệt độ bình dầu', width: item_width, height: item_height, value: nhiet_do_binh_dau, icon: Icons.thermostat_outlined),
                        GridItem1(title: 'Áp suất', width: item_width, height: item_height, value: ap_suat, icon: Icons.thermostat_outlined),
                        GridItem1(title: 'Độ ẩm', width: item_width, height: item_height, value: do_am, icon: Icons.water_drop_outlined)
                        
                       
                      ],
                    )
                ],
                ) ,)
                
              );
            },
          ),
      )
    );
  }
}