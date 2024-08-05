import 'package:flutter/material.dart';
import 'ProfileMenu.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../values/app_colors.dart';
import '../../values/app_strings.dart';
import '../../values/app_routes.dart';
import '../../utils/helpers/navigation_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/Auth.service/Auth.service.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ProfileMenuWidget(
                  title: AppStrings.ProfileSetting,
                  icon: LineAwesomeIcons.cog_solid,
                  onPress: () {
                    NavigationHelper.pushNamed(
                      AppRoutes.setting,
                    );
                  }),
              const SizedBox(
                height: 15,
              ),
              //  ProfileMenuWidget(title: "Billing Details", icon: LineAwesomeIcons.walking_solid, onPress: () {}),
              ProfileMenuWidget(
                  title: AppStrings.ProfileUser,
                  icon: LineAwesomeIcons.user_check_solid,
                  onPress: () {
                    NavigationHelper.pushNamed(
                      AppRoutes.manageaccount,
                    );
                  }),
              const SizedBox(
                height: 15,
              ),

              ProfileMenuWidget(
                  title: AppStrings.ProfileInfomation,
                  icon: LineAwesomeIcons.info_solid,
                  onPress: () {
                    NavigationHelper.pushNamed(
                      AppRoutes.info,
                    );
                  }),
              const SizedBox(
                height: 15,
              ),
              ProfileMenuWidget(
                  title: AppStrings.logout,
                  icon: LineAwesomeIcons.arrow_alt_circle_down_solid,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: ()async {
                   await AuthService.logOut();
                     NavigationHelper.pushReplacementNamed(
                        AppRoutes.login,
                      );
                  }),
            ],
          ),
        ),
      );
  }
}
