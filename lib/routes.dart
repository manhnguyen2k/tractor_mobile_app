import 'package:flutter/material.dart';
import 'package:tractorapp/Screens/Tractor.screen/TractorDetail_chart/index.dart';
import './Screens/Auth.screen/login_screen.dart';
import './Screens/Auth.screen/register_screen.dart';
import 'Screens/App.main.screen/BottomBar.dart';
import 'utils/common_widgets/invalid_route.dart';
import 'values/app_routes.dart';
import 'Screens/Profile.screen/Setting.csreen/Setting.screen.dart';
import 'Screens/Profile.screen/Account_information.screen/index.dart';
import 'Screens/Profile.screen/App_infomation.screen/InfomationScreen.dart';
import './Screens/Field.screen/AddField.screens.dart';
import './Screens/Notifications.screen/index.dart';
import 'Screens/Tractor.screen/TractorDetail_chart/wigets/youtube.srteam.dart';
import './Screens/Profile.screen/Account_information.screen/Change_password.dart';
import 'Screens/Tractor.screen/TractorDetail_chart/test.dart';
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
      case AppRoutes.detail:
        return getRoute(
            widget: TractorDetailChart(
          tractorId: '',
          token: '',
          tractorName: '',
        ));
      case AppRoutes.changepw:
        return getRoute(widget: ChangePassword());
case AppRoutes.test:
        return getRoute(widget:const OrientationList(title: 'test',));

   

   
      default:
        return getRoute(widget: const InvalidRoute());
    }
  }
}
