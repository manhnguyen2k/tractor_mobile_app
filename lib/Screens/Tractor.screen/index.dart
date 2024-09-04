import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tractorapp/values/app_colors.dart';
import 'index_tractor_inline.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../values/app_strings.dart';
import '../../service/Tractor.service/Tractor.service.dart';
import '../../utils//common_widgets/connection.err.dart';
import 'dart:developer';

final url = dotenv.env['BASE_URL'];

class ListTractor extends StatefulWidget {
  final Function(String, int) onTabChange;

  const ListTractor({Key? key, required this.onTabChange}) : super(key: key);
  @override
  State<ListTractor> createState() => _ListTractorState();
}

class _ListTractorState extends State<ListTractor>
    with AutomaticKeepAliveClientMixin {
  late bool isLoading;
  List isError = [];
  String _token = '';
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  String getToken() {
    String token = '';
    try {
      Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
      _sprefs.then(
        (prefs) {
          token = prefs.getString('accesstoken') ?? '';
        },
      );
    } catch (error) {
      return '';
    }
    return token;
  }

  late IO.Socket socket;
  List<String> online_tractor = [];
  List<String> all_tractor = [];
  Map<String, dynamic> tractorSockets = {};

  Future<void> _loadData() async {
    all_tractor.clear();
    try {
      final data = await TractorService.getAllTractor();

      final a = jsonDecode(data.body);
      int count = 0;
      for (var item in a['data']) {
        //count ++;
        log('$count');
        setState(() {
          all_tractor.add(item['_id']);
          //isError = false;
        });
      }
//count= 0 ;
    } catch (e) {
      log('errrr${e.toString()}:');
      setState(() {
        isError.add(e.toString());
      });
    }
  }

  void connect(IO.Socket socket) async {
    if (socket.disconnected) {
      socket.connect();

      socket.on('online-tractor', (data) {
        List<String> newOnlineTractor = List<String>.from(data);
        if (online_tractor != newOnlineTractor) {
          setState(() {
            online_tractor = newOnlineTractor;
          });
        }
      });
    }
  }

  Future<void> _initialize() async {
    setState(() {
      isLoading = true;
    });

    await _loadData();

    setState(() {
      isLoading = false;
    });

    Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
    _sprefs.then(
      (prefs) {
        String token = prefs.getString('accesstoken') ?? '';
        setState(() {
          _token = token;
        });
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
  void initState() {
    // log('initttttttttttt');
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    //log('disposssssssss');
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    //await Future.delayed(const Duration(seconds: 2));
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
   
     final Color background;
   
    switch (theme.brightness) {
      case Brightness.light:
          background = AppColors.cardBackgroundColor_light;
      case Brightness.dark:
          background = AppColors.cardBackgroundColor;
        
        break;
      default:  background = Colors.white;
    }
    //log('loading2222: ${card_color}');
    //final textColor = theme.textTheme.bodyMedium;
    return
        // isError? ConnectionFailed():
        RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refresh,
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: isError.isEmpty//isError.isNotEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.err_disconected_server,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      _refreshIndicatorKey.currentState?.show();
                                    },
                                    child: Text(AppStrings.reload))
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: 6,//all_tractor.length
                            itemBuilder: (context, index) {
                              //bool isOnline = online_tractor.contains(all_tractor[index]);
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  constraints: const BoxConstraints(
                                    minHeight: 100.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: background,
                                    border: Border.all(
                                     
                                      width: 0.0,
                                    ),
                                    borderRadius: BorderRadius.circular(15.0),
                                 /*
                                    boxShadow: isOnline
                                        ? [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ]
                                        : [],
                                        */
                                  ),
                                  child: Tractor_line(
                                    isOnline: true,
                                    tractorId: 'all_tractor[index]',
                                    token: _token,
                                    onTabChange: widget.onTabChange,
                                  ),
                                ),
                              );
                            },
                          ),
                  ));
  }

  @override
  bool get wantKeepAlive => true;
}
