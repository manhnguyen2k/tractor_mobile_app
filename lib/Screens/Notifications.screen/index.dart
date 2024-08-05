import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../values/app_colors.dart';
import '../../utils/common_widgets/appbar.dart';
import '../../values/app_strings.dart';
import '../../service/firebase.service/firebase.dart';
import 'dart:async';
import 'dart:developer';
import '../../service/User.service/User.service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import '../../values/app_colors.dart';

class NotificationDemo extends StatefulWidget {
  @override
  _NotificationDemoState createState() => _NotificationDemoState();
}

class _NotificationDemoState extends State<NotificationDemo> {
//  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late FirebaseApi _firebaseApi;
  late StreamSubscription<RemoteMessage> _subscription;
  List<dynamic> notidata = [];
  Future<void> loadNoti() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('deviceToken', fcmToken ?? '');
    final String? uid = prefs.getString('uid');
    final data = await UserService.getNoti(uid ?? '');
    final Map<String, dynamic> responseData = json.decode(data.body);
    final List<dynamic> userData = (responseData['data']);
    setState(() {
      notidata = userData;
    });
    log('uuuuuu: ${userData}');
  }

  @override
  void initState() {
    super.initState();
    loadNoti();
    // _firebaseApi.initNotification();
  }

  String timeAgo(String isoString) {
    DateTime inputTime = DateTime.parse(isoString);
    DateTime currentTime = DateTime.now();
    Duration difference = currentTime.difference(inputTime);

    if (difference.inMinutes < 1) {
      return 'Vừa xong';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inDays <= 2) {
      return '${difference.inDays} ngày trước';
    } else {
      return DateFormat('dd/MM/yyyy').format(inputTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.notiTitle,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        //  backgroundColor:  AppColors.backgroundColor,
        body: RefreshIndicator(
            onRefresh: () => loadNoti(),
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: ListView.builder(
                  itemCount: notidata.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: 
                           Material(
                            color: AppColors.textColor,
                            child:
                            Container(
                              decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                      width: 0.0,
                    ),
                    borderRadius: BorderRadius.circular(15.0),),
                              child:   ListTile(
                              leading: Container(
                                width: 40,
                                height: 40,
                                child: Icon(Icons.notifications,
                                    color: Colors.black),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notidata[index]['title'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16),
                                  ),
                                  Text(notidata[index]['data'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Colors.grey)),
                                  Text(timeAgo(notidata[index]['createdAt']),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.grey))
                                ],
                              ),
                            ),
                            )
                           
                          ),
                    );
                  }),
            )));
  }
}
