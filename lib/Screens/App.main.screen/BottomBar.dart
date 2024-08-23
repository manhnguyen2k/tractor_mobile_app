import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:tractorapp/values/app_colors.dart';
import '../Tractor.screen/index.dart';
import '../Map.screen/Map.dart';
import '../Home.screen/Home.dart';
import '../Profile.screen/index.dart';
import 'dart:developer';
import '../Field.screen/Field.screen.dart';
import '../../utils/common_widgets/appbar.dart';
import '../../utils/helpers/navigation_helper.dart';
import '../../values/app_routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../service/Event.service/Event.service.dart';
import 'dart:async';
import '../../service/firebase.service/firebase.dart';
import 'package:provider/provider.dart';
import '../../values/app_strings.dart';

class AnimatedBarExample extends StatefulWidget {
  const AnimatedBarExample({super.key});

  @override
  State<AnimatedBarExample> createState() => _AnimatedBarExampleState();
}

class _AnimatedBarExampleState extends State<AnimatedBarExample> {
  int selected = 0;
  int type = 0;
  bool isSetcenterMap = false;
  String _selected_center = 'None';
  final PageController _pageController = PageController();

  final List<String> _titles = [
    AppStrings.homeTitleAppbarr,
    AppStrings.tractorTitleAppbarr,
    AppStrings.FieldTitle,
    AppStrings.mapTitleAppbarr,
    AppStrings.ProfileTitle,
  ];

  void _firebase() async {
    await FirebaseApi().initNotification(context);
  }

  void _changeCenterMapTab(String selected_center, int _type) {
    setState(() {
      isSetcenterMap = true;
      _selected_center = selected_center;
      selected = 3;
      _pageController.jumpToPage(3);
      type = _type;
    });
  }

  @override
  void initState() {
    super.initState();
    _firebase();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasNotification = Provider.of<BoolNotifier>(context).value;

    return WillPopScope(
        onWillPop: () async {
          if (selected != 0) {
            setState(() {
              selected = 0;
              _pageController.jumpToPage(0);
            });
            return false;
          }
          return true;
        },
        child: Scaffold(
            appBar: CustomAppBar(
              title: _titles[selected],
              actions: [
                IconButton(
                  onPressed: () {
                    NavigationHelper.pushNamed(AppRoutes.noti);
                  },
                  icon: SvgPicture.asset(
                    hasNotification
                        ? 'assets/image/notification-alert-svgrepo-com (4).svg'
                        : 'assets/image/notification-svgrepo-com.svg',
                    width: 24.0,
                    height: 24.0,
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
                  title: Text(AppStrings.BottombarHome),
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
                  title: Text(AppStrings.BottombarTractor),
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
                  title: Text(AppStrings.FieldBottomTitle),
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
                  title: Text(AppStrings.mapTitleAppbarr),
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
                  title: Text(AppStrings.BottombarProfile),
                ),
              ],
              hasNotch: true,
              currentIndex: selected,
              notchStyle: NotchStyle.square,
              onTap: (index) {
                setState(() {
                  selected = index;
                  if ((index - _pageController.page!.toInt()).abs() == 1) {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
                  } else {
                    _pageController.jumpToPage(index);
                  }
                });
              },
            ),
            body: SafeArea(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    selected = index;
                  });
                },
                children: [
                  const Home(),
                  ListTractor(onTabChange: _changeCenterMapTab),
                  Fields(onTabChange: _changeCenterMapTab),
                  MapScreen(
                    center: _selected_center,
                    type: type,
                    onTabChange: _changeCenterMapTab,
                  ),
                  const ProfileScreen(),
                ],
              ),
            )));
  }
}
