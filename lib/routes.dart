import 'package:flutter/material.dart';
import 'package:tractorapp/Screens/Tractor.screen/TractorDetail/index.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'Screens/Home.screen/BottomBar.dart';
import 'utils/common_widgets/invalid_route.dart';
import 'values/app_routes.dart';
import 'Screens/Profile.screen/Setting.screen.dart';
import 'Screens/Profile.screen/ManageAccount.dart';
import 'Screens/Profile.screen/InfomationScreen.dart';
import './Screens/Field.screen/AddField.screens.dart';
import './Screens/Notifications.screen/index.dart';
import './Screens/Tractor.screen/TractorDetail/wigets/youtube.srteam.dart';

class Routes {
  const Routes._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Route<dynamic> getRoute({
      required Widget widget,
      bool fullscreenDialog = false,
    }) {
      return MaterialPageRoute<void>(
        builder: (context) => widget,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
      );
    }

    switch (settings.name) {
      case AppRoutes.login:
        return getRoute(widget: const LoginPage());

      case AppRoutes.register:
        return getRoute(widget: const RegisterPage());

      case AppRoutes.home:
        return getRoute(widget: const AnimatedBarExample());

      case AppRoutes.setting:
        return getRoute(widget: SettingScreen());
      case AppRoutes.manageaccount:
        return getRoute(widget: ManageAccount());
      case AppRoutes.info:
        return getRoute(widget: Infomation());
      case AppRoutes.add_field:
        return getRoute(widget: const AddField());
      case AppRoutes.noti:
        return getRoute(widget: NotificationDemo());
     // case AppRoutes.stream:
      //  return getRoute(widget: YouTubePlayerScreen());
      case AppRoutes.detail:
        return getRoute(widget: TractorDetailChart(tractorId: '',token: '',tractorName: '',));
      
      default:
        return getRoute(widget: const InvalidRoute());
    }
  }
}
