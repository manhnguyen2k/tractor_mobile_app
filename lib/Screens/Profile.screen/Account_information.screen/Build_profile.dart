import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import './List_account_info.dart';
import '../ProfileMenu.dart';
import '../../../values/app_string1.dart';
import 'dart:developer';
import '../../../utils/helpers/navigation_helper.dart';
import '../../../values/app_routes.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  void onPress() {
    log('press');
  }
  void changepw() {
    log('press');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final leadingColor = theme.listTileTheme.iconColor;
    final titleStyle = theme.listTileTheme.titleTextStyle;
    final tileColor = theme.listTileTheme.tileColor;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// -- IMAGE
            Center(
              child: Stack(
                children: [
                  const SizedBox(
                    width: 240,
                    height: 240,
                    child: CircleAvatar(
                     backgroundImage:AssetImage('assets/image/user.png'),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: 
                      InkWell(
                        onTap: (){},
                        borderRadius: BorderRadius.circular(100),
                        child:  Icon(
                        Icons.edit,
                        size: 20,
                        color: leadingColor,
                      ),
                      )
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),

            ItemAccountInfo(
                title: 'test@gmail.com',
                icon: Icon(Icons.email_outlined, color: leadingColor),
                canEdit: false,
                onPress: onPress),

            ItemAccountInfo(
                title: '0123456789',
                icon: Icon(Icons.local_phone, color: leadingColor),
                canEdit: true,
                onPress: onPress),

            ItemAccountInfo(
                title: 'Nguyen Van Manh',
                icon: Icon(Icons.person, color: leadingColor),
                canEdit: true,
                onPress: onPress),
                
             ItemAccountInfo(
                title: 'test address, Viet Nam',
                icon: Icon(Icons.home, color: leadingColor),
                canEdit: true,
                onPress: onPress),

                const Divider(),
            
             ProfileMenuWidget(
                  title: AppStrings1.account_change_password,
                  icon: Icons.lock,
                   textColor: Colors.red,
                  onPress: () {
                  NavigationHelper.pushNamed(
                      AppRoutes.changepw,
                    );
                  }),
          ],
        ),
      ),
    );
  }
}
