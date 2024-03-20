import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/screens/book_apointment/book_apointment_page.dart';
import 'package:hvdc_user/screens/homepage.dart';
import 'package:hvdc_user/screens/profile_screens/profile_page.dart';

class BottomNavigationController extends GetxController {
  RxInt currentIndex = RxInt(0);
  final RxBool isProfileOpen = false.obs;

  List pages = [
    Homepage(),
    AppointmentBookingScreen(),
    Placeholder(),
    ProfilePage()
  ];

  void onTap(int index) {
    currentIndex.value = index;
  }
}
