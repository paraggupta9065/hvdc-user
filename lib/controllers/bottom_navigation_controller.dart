import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/screens/book_apointment/book_apointment_page.dart';
import 'package:hvdc_user/screens/bookings.dart';
import 'package:hvdc_user/screens/home/homepage.dart';
import 'package:hvdc_user/screens/profile_screens/profile_page.dart';
import 'package:hvdc_user/utils/articles.dart';

class BottomNavigationController extends GetxController {
  RxInt currentIndex = RxInt(0);
  final RxBool isProfileOpen = false.obs;

  PageController pageController = PageController();

  List<Widget> pages = [
    const MainHome(),
    const Bookings(),
    const Articles(),
    ProfilePage()
  ];

  void onTap(int index) {
    currentIndex.value = index;
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 700), curve: Curves.ease);
  }
}
