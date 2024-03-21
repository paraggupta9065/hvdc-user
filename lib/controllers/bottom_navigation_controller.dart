import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/screens/homepage.dart';
import 'package:hvdc_user/screens/profile_screens/profile_page.dart';
import 'package:hvdc_user/utils/articles.dart';

class BottomNavigationController extends GetxController {
  RxInt currentIndex = RxInt(0);
  final RxBool isProfileOpen = false.obs;

  List pages = [
    const Homepage(),
    const Placeholder(),
    const Articles(),
    const ProfilePage()
  ];

  void onTap(int index) {
    currentIndex.value = index;
  }
}
