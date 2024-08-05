import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../User.service/User.service.dart';
import '../../values/app_routes.dart';
import '../../utils/helpers/navigation_helper.dart';
import '../Event.service/Event.service.dart';
Future<void> handlerBackgroundMesage(RemoteMessage mesage) async {
  log('Title: ${mesage.notification?.title}');
  log('Body: ${mesage.notification?.body}');
  log('Payload: ${mesage.data}');
  //
}

class FirebaseApi {
  final _firebaseMessage = FirebaseMessaging.instance;
    final EventService _eventService = EventService();
    late StreamSubscription<String> _subscription;
  Future<void> initNotification() async {
    await _firebaseMessage.requestPermission();
    final fcmToken = await _firebaseMessage.getToken();
    log('Token: $fcmToken');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('deviceToken', fcmToken ?? '');
    final String? uid = prefs.getString('uid');
    log('uid: $uid');
    await UserService.saveDeviceToken(fcmToken ?? '', uid ?? '');
    FirebaseMessaging.onBackgroundMessage(handlerBackgroundMesage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Titleopen: ${message.notification?.title}');
      log('Bodyopen: ${message.notification?.body}');
      log('Payloadopen: ${message.data}');
     // prefs.setBool('isNoti', true);
      //_eventService.addEvent(true);
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

