import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:tractorapp/values/app_colors.dart';
import 'package:tractorapp/values/app_strings.dart';
import '../Tractor.screen/index.dart';
import '../Map.screen/Map.dart';
import 'Home.dart';
import '../Profile.screen/Profile.dart';
import 'dart:developer';
import '../Field.screen/Field.screen.dart';
import '../../utils/common_widgets/appbar.dart';
import '../../utils/helpers/navigation_helper.dart';
import '../../values/app_routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../service/Event.service/Event.service.dart';
import 'dart:async';

class AnimatedBarExample extends StatefulWidget {
  const AnimatedBarExample({super.key});

  @override
  State<AnimatedBarExample> createState() => _AnimatedBarExampleState();
}

class _AnimatedBarExampleState extends State<AnimatedBarExample> {
  final EventService _eventService = EventService();
  late StreamSubscription<bool> _subscription;
  int selected = 0;
  int type = 0;
  bool isSetcenterMap = false;
  String _selected_center = 'None';
  final List<String> _titles = [
    AppStrings.homeTitleAppbarr,
    AppStrings.tractorTitleAppbarr,
    AppStrings.FieldTitle,
    AppStrings.mapTitleAppbarr,
    AppStrings.ProfileTitle,
  ];
  void _changeCenterMapTab(String selected_center, int _type) {
    setState(() {
      isSetcenterMap = true;
      _selected_center = selected_center;
      selected = 3;
      type = _type;
    });
  }

  @override
  void initState() {
    super.initState();
    _subscription = _eventService.eventStream.listen((event) {
      log('Received event: $event');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: _titles[selected],
          actions: [
            IconButton(
              onPressed: () {
                NavigationHelper.pushNamed(AppRoutes.noti);
              },
              icon: SvgPicture.asset(
                'assets/image/notification-alert-svgrepo-com (4).svg',

                width: 24.0, // Set the size as needed
                height: 24.0, // Set the size as needed
              ),
            )
          ],
        ),
        extendBody: true,
        bottomNavigationBar: StylishBottomBar(
          backgroundColor: AppColors.darkBlue,
          option: DotBarOptions(
              dotStyle: DotStyle.tile, inkColor: AppColors.primaryColor),
          items: [
            BottomBarItem(
              icon: const Icon(
                Icons.home_outlined,
              ),
              selectedIcon: const Icon(Icons.house_rounded),
              selectedColor: AppColors.primaryColor,
              unSelectedColor: AppColors.textColor,
              title: const Text(AppStrings.BottombarHome),
            ),
            BottomBarItem(
              icon: const ImageIcon(
                AssetImage('assets/image/tractor-icon.png'),
              ),
              unSelectedColor: AppColors.textColor,
              selectedIcon: const ImageIcon(
                AssetImage('assets/image/tractor-icon.png'),
              ),
              selectedColor: AppColors.primaryColor,
              title: const Text(AppStrings.BottombarTractor),
            ),
            BottomBarItem(
              icon: const ImageIcon(
                AssetImage('assets/image/field.png'),
              ),
              selectedIcon: const ImageIcon(
                AssetImage('assets/image/field.png'),
              ),
              selectedColor: AppColors.primaryColor,
              unSelectedColor: AppColors.textColor,
              title: const Text(AppStrings.FieldBottomTitle),
            ),
            BottomBarItem(
              icon: const Icon(
                Icons.map_outlined,
              ),
              selectedIcon: const Icon(
                Icons.map,
              ),
              selectedColor: AppColors.primaryColor,
              unSelectedColor: AppColors.textColor,
              title: const Text(AppStrings.BottombarMap),
            ),
            BottomBarItem(
              icon: const Icon(
                Icons.person_outline,
              ),
              selectedIcon: const Icon(
                Icons.person,
              ),
              selectedColor: AppColors.primaryColor,
              unSelectedColor: AppColors.textColor,
              title: const Text(AppStrings.BottombarProfile),
            ),
          ],
          hasNotch: true,
          currentIndex: selected,
          notchStyle: NotchStyle.square,
          onTap: (index) {
            setState(() {
              selected = index;
            });
          },
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Offstage(
                offstage: selected != 0,
                child: Home(),
              ),
              Offstage(
                offstage: selected != 1,
                child: ListTractor(
                  onTabChange: _changeCenterMapTab,
                ),
              ),
              Offstage(
                offstage: selected != 2,
                child: Fields(onTabChange: _changeCenterMapTab),
              ),
              Offstage(
                offstage: selected != 3,
                child: MapScreen(
                  center: _selected_center,
                  type: type,
                  onTabChange: _changeCenterMapTab,
                ),
              ),
              Offstage(
                offstage: selected != 4,
                child: const ProfileScreen(),
              ),
            ],
          ),
        ));
  }
}
