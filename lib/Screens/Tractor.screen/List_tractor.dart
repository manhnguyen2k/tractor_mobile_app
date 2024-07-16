import 'package:flutter/material.dart';
import 'package:tractorapp/values/app_colors.dart';
import '../../values/app_theme.dart';
import 'dart:developer';
import 'Tractor_line.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../values/app_strings.dart';

final url = dotenv.env['BASE_URL'];

class ListTractor extends StatefulWidget {
   final Function(String) onTabChange;

  const ListTractor({Key? key, required this.onTabChange}) : super(key: key);
  @override
  State<ListTractor> createState() => _ListTractorState();
}

class _ListTractorState extends State<ListTractor>  {
  //final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _token = '';

  String getToken()  {
    String token = '';
  try {
     Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
      _sprefs.then((prefs) {
        // ...
       // log('wwwwwwww');
       token = prefs.getString('accesstoken') ?? '';
       // log('token:$token');
      
      }, );
  } catch (error) {
    print("SharedPreferences ERROR = $error");
    return ''; // Or handle the error as needed
  }
  return token;
}

  late IO.Socket socket;
  List<String> online_tractor = [];
  Map<String, dynamic> tractorSockets = {};
  void connect(IO.Socket socket) async {
    print('eeeeeeeeeeeeee');
    if (socket.disconnected) {
      socket.connect();
     // log('onnnnn');
      // Wait until the completer is marked as complete

      socket.on('online-tractor', (data) {
        // print('---------------------------mount Chart update');
       // log('tttttttttttttttt');

        List<String> newOnlineTractor = List<String>.from(data);
        print(newOnlineTractor);
        // Kiểm tra nếu dữ liệu mới khác với dữ liệu cũ
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
   // final String token = _incrementCounter();
    Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
      _sprefs.then((prefs) {
        // ...
       // log('wwwwwwww');
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
      }, );

   
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
              color: Colors.grey, // Set the text color here
              fontSize: 24.0, // Set the font size here
              fontWeight: FontWeight.normal),
        ),
      ),
      backgroundColor: AppColors.bodyColor,
      body: ListView.builder(
        itemCount: online_tractor.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(
                5.0), // Increase vertical padding for more spacing
            child: Container(
               constraints: const BoxConstraints(
                minHeight: 100.0, // Chiều cao tối thiểu là 100 đơn vị
     // Chiều rộng tối thiểu là 200 đơn vị
  ),
             // height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white, // Border color
                  width: 0.0, // Border width
                ),
                borderRadius: BorderRadius.circular(
                    15.0),
                     boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Màu của bóng đổ
            spreadRadius: 1, // Độ rộng bóng đổ
            blurRadius: 5, // Độ mờ của bóng đổ
            offset: Offset(0, 3), // Vị trí bóng đổ (x, y)
          ),
        ], // Optional: to give rounded corners
              ),
              child: Tractor_line(
                tractorId: online_tractor[index],
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
