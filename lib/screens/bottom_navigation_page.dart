import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/controllers/bottom_navigation_controller.dart';
import 'package:hvdc_user/controllers/homepage_controller.dart';
import 'package:hvdc_user/utils/colors.dart';

// ignore: must_be_immutable
class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  bool biometricsAuthenticationStatus = false;

  final BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());

  HomepageController homepageController = Get.put(HomepageController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: bottomNavigationController.pageController,
          children: bottomNavigationController.pages,
          onPageChanged: (value) {
            bottomNavigationController.currentIndex.value = value;
          },
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: kGreen,
            unselectedItemColor: kGrey,
            currentIndex: bottomNavigationController.currentIndex.value,
            onTap: (index) {
              bottomNavigationController.onTap(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.house,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.calendar,
                ),
                label: "Booking",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.doc_plaintext,
                ),
                label: "Articles",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.person,
                ),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
