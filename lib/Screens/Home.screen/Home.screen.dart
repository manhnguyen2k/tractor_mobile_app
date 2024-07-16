import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:tractorapp/values/app_colors.dart';
import 'package:tractorapp/values/app_strings.dart';
import '../Tractor.screen/List_tractor.dart';
import '../Map.screen/Map.dart';
import 'Home.dart';
import '../Profile.screen/Profile.dart';
import 'dart:developer';
class AnimatedBarExample extends StatefulWidget {
  const AnimatedBarExample({super.key});

  @override
  State<AnimatedBarExample> createState() => _AnimatedBarExampleState();
}

class _AnimatedBarExampleState extends State<AnimatedBarExample> {
  int selected = 0;
  bool isSetcenterMap = false;
  String _selected_center = 'None';
  void _changeCenterMapTab(String selected_center) {
log(selected_center);
    setState(() {
       isSetcenterMap = true;
    _selected_center = selected_center;
      selected = 2;
     

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      bottomNavigationBar: StylishBottomBar(
        backgroundColor: AppColors.darkBlue,
        option: DotBarOptions(
          dotStyle: DotStyle.tile,
          inkColor: AppColors.primaryColor
        ),
        items: [
          BottomBarItem(
            icon: const Icon(
              Icons.home_outlined,
            ),
            selectedIcon: const Icon(Icons.house_rounded),
            selectedColor: AppColors.primaryColor,
            unSelectedColor: Colors.grey,
            title: const Text(AppStrings.BottombarHome),
          ),
          BottomBarItem(
            icon: const ImageIcon(
              AssetImage('assets/image/tractor-icon.png'),
            ),
            selectedIcon: const ImageIcon(
              AssetImage('assets/image/tractor-icon.png'),
            ),
            selectedColor: AppColors.primaryColor,
            title: const Text(AppStrings.BottombarTractor),
          ),
          BottomBarItem(
            icon: const Icon(
              Icons.map_outlined,
            ),
            selectedIcon: const Icon(
              Icons.map,
            ),
            selectedColor: AppColors.primaryColor,
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
              child: ListTractor(onTabChange: _changeCenterMapTab,),
            ),
            Offstage(
              offstage: selected != 2,
              child:  MapScreen(center:  _selected_center, onTabChange: _changeCenterMapTab, ),
            ),
            Offstage(
              offstage: selected != 3,
              child:  ProfileScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
