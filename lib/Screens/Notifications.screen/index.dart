import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tractorapp/values/app_strings.dart';
import '../../values/app_colors.dart';
import '../../utils/common_widgets/appbar.dart';
//import '../../values/app_strings.dart';
import '../../service/firebase.service/firebase.dart';
import 'dart:async';
import 'dart:developer';
import '../../service/User.service/User.service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import '../../values/app_colors.dart';
import 'package:provider/provider.dart';
import '../../service/Event.service/Event.service.dart';
import '../../values/app_string1.dart';

class NotificationDemo extends StatefulWidget {
  @override
  _NotificationDemoState createState() => _NotificationDemoState();
}

class _NotificationDemoState extends State<NotificationDemo> {
//  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool isLoading = false;
  bool isResult = false;
  List<dynamic> notidata = [];
  Future<void> loadString() async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
    final selected = prefs.getString('selected_language');
    log('selected language: $selected');
    await AppStrings1.loadLanguageStrings();
  }
  Future<void> loadNoti() async {
    //   if (!mounted) return;
    setState(() {
      isLoading = true;
    });
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('deviceToken', fcmToken ?? '');
      final String? uid = prefs.getString('uid');
      final data = await UserService.getLimitNoti(uid ?? '');
      final Map<String, dynamic> responseData = json.decode(data.body);
      final List<dynamic> userData = (responseData['data']);
      if (mounted) {
        setState(() {
          notidata = userData;
          isLoading = false;
          isResult = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
          isResult = false;
        });
      }
    }
  }

  Future<void> loadmoreNoti() async {
    setState(() {
      isLoading = true;
    });
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('deviceToken', fcmToken ?? '');
      final String? uid = prefs.getString('uid');
      final data = await UserService.getAllNoti(uid ?? '');
      final Map<String, dynamic> responseData = json.decode(data.body);
      final List<dynamic> userData = (responseData['data']);
      setState(() {
        notidata = userData;
        isLoading = false;
        isResult = true;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
          isResult = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadString();
    loadNoti();
    log('tesssss ${AppStrings1.AccountManageTitle}');
    // _firebaseApi.initNotification();
  }

  String timeAgo(String isoString) {
    DateTime inputTime = DateTime.parse(isoString);
    DateTime currentTime = DateTime.now();
    Duration difference = currentTime.difference(inputTime);

    if (difference.inMinutes < 1) {
      return AppStrings1.noti_date_justnow;
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${AppStrings1.noti_date_minute_ago}';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${AppStrings1.noti_date_hours_ago}';
    } else if (difference.inDays <= 2) {
      return '${difference.inDays} ${AppStrings1.noti_date_day_ago}';
    } else {
      return DateFormat('dd/MM/yyyy').format(inputTime);
    }
  }

  @override
  void dispose() {
    // Any cleanup if necessary

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: AppStrings1.notiTitle,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        //  backgroundColor:  AppColors.backgroundColor,
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : isResult
                ? RefreshIndicator(
                    onRefresh: () => loadNoti(),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: ListView.builder(
                          itemCount: notidata.length + 1,
                          itemBuilder: (context, index) {
                            if (index < notidata.length) {
                              return Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: AppColors.bodyColor,
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                        width: 0.5,
                                      ),
                                    ),
                                    //borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Material(
                                    color: AppColors.bodyColor,
                                    child: InkWell(
                                      onTap: () {
                                        if (notidata[index]['type'] == 1) {
                                          log("máy");
                                        }
                                      },
                                      child: ListTile(
                                        leading: Container(
                                          width: 40,
                                          height: 40,
                                          child: const Icon(Icons.notifications,
                                              color: Colors.black),
                                        ),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              notidata[index]['title'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 16),
                                            ),
                                            Text(notidata[index]['data'],
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14,
                                                    color: Colors.grey)),
                                            Text(
                                                timeAgo(notidata[index]
                                                    ['createdAt']),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    color: Colors.grey))
                                          ],
                                        ),
                                        trailing: PopupMenuButton<String>(
                                          icon: Image.asset(
                                            'assets/image/menu.png',
                                            width: 20,
                                            height: 20,
                                          ),
                                          onSelected: (String result) {
                                            // Handle menu action here
                                            log("Selected: ${notidata[index]['_id']}");
                                          },
                                          itemBuilder: (BuildContext context) =>
                                              <PopupMenuEntry<String>>[
                                            PopupMenuItem<String>(
                                              value: 'delete',
                                              child: Text(
                                                  AppStrings1.noti_delete_noti),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            /*
                        else if (index == notidata.length &&
                            notidata.length > 21) {
                          return InkWell(
                            onTap: loadmoreNoti,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text("Thông báo cũ hơn"),
                            ),
                          );
                        }
                        */
                          }),
                    ))
                : Center(
                    child: Text(AppStrings1.err_disconected_server),
                  ));
  }
}
