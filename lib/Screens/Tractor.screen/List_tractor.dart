import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tractorapp/values/app_colors.dart';
import 'Tractor_line.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../values/app_strings.dart';
import '../../service/Tractor.service/Tractor.service.dart';
import 'dart:developer';
final url = dotenv.env['BASE_URL'];

class ListTractor extends StatefulWidget {
  final Function(String, int) onTabChange;

  const ListTractor({Key? key, required this.onTabChange}) : super(key: key);
  @override
  State<ListTractor> createState() => _ListTractorState();
}

class _ListTractorState extends State<ListTractor> {
  //final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _token = '';

  String getToken() {
    String token = '';
    try {
      Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
      _sprefs.then(
        (prefs) {
          // ...
          // log('wwwwwwww');
          token = prefs.getString('accesstoken') ?? '';
          // log('token:$token');
        },
      );
    } catch (error) {
      print("SharedPreferences ERROR = $error");
      return ''; // Or handle the error as needed
    }
    return token;
  }

  late IO.Socket socket;
  List<String> online_tractor = [];
   List<String> all_tractor = []; 
  Map<String, dynamic> tractorSockets = {};

  Future <void> _loadData () async{
    try {
       final data = await TractorService.getAllTractor();
       final a = jsonDecode(data.body) ;
       for(var item in a['data']){
        setState(() {
          all_tractor.add(item['_id']);
        });
        
       }
  log('dataaa: ${all_tractor}');
    } catch (e) {
      log('errrr${e.toString()}:');
    }
  }

  void connect(IO.Socket socket) async {
    print('eeeeeeeeeeeeee');
    if (socket.disconnected) {
      socket.connect();

      socket.on('online-tractor', (data) {
        List<String> newOnlineTractor = List<String>.from(data);
        if (online_tractor != newOnlineTractor) {
          setState(() {
            online_tractor = newOnlineTractor;
          });
        }

        // print(dataPoints);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    // final String token = _incrementCounter();
    Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
    _sprefs.then(
      (prefs) {
        String token = prefs.getString('accesstoken') ?? '';
        setState(() {
          _token = token;
        });
        //   log('token:$token');
        Map<String, String> extraHeaders = {
          'token': token,
        };
        socket = IO.io(url, <String, dynamic>{
          'transports': ['websocket'],
          'force new connection': true,
          'extraHeaders': extraHeaders,
        });

        connect(socket);
      },
    );
  }

  @override
  void dispose() {
    socket.onDisconnect((_) {
      print('DisConnected to the socket server');
    });
    socket.disconnect();

    socket.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        title: const Text(
          AppStrings.tractorTitleAppbarr,
          style: TextStyle(
              color: Colors.grey,
              fontSize: 24.0,
              fontWeight: FontWeight.normal),
        ),
      ),
      backgroundColor: AppColors.bodyColor,
    body: ListView.builder(
  itemCount: all_tractor.length,
  itemBuilder: (context, index) {
    bool isOnline = online_tractor.contains(all_tractor[index]);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 100.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
            width: 0.0,
          ),
          borderRadius: BorderRadius.circular(15.0),
           boxShadow: isOnline
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Tractor_line(
          isOnline: isOnline,
          tractorId: all_tractor[index],
          token: _token,
          onTabChange: widget.onTabChange,
        ),
      ),
    );
  },
),
    );
  }
}
