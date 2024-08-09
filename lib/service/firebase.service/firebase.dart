import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../User.service/User.service.dart';
import '../../values/app_routes.dart';
import '../../utils/helpers/navigation_helper.dart';
import '../Event.service/Event.service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FirebaseApi {
  final _firebaseMessage = FirebaseMessaging.instance;
  
  Future<void> initNotification(BuildContext context) async {
    await _firebaseMessage.requestPermission();
    final fcmToken = await _firebaseMessage.getToken();
    log('Token: $fcmToken');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('deviceToken', fcmToken ?? '');
    final String? uid = prefs.getString('uid');
    log('uid: $uid');
    await UserService.saveDeviceToken(fcmToken ?? '', uid ?? '');
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
  log('Thông báo nền nhận được: ${message.messageId}');
  log('Nội dung thông báo: ${message.notification?.body}');
});
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Titleopen: ${message.notification?.title}');
      log('Bodyopen: ${message.notification?.body}');
      log('Payloadopen: ${message.data}');
      Provider.of<BoolNotifier>(context, listen: false).setValue(true);
    });
    final FirebaseMessaging _messaging = FirebaseMessaging.instance;
    _messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        _handleMessage(message);
      }
    });
  }
  void _handleMessage(RemoteMessage message) {
    NavigationHelper.pushNamed(AppRoutes.noti);
  }
  

}

