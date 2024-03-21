import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/controllers/bottom_navigation_controller.dart';
import 'package:hvdc_user/utils/colors.dart';

class BottomNavigator extends StatelessWidget {
  BottomNavigator({super.key});

  bool biometricsAuthenticationStatus = false;

  final BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => bottomNavigationController
          .pages[bottomNavigationController.currentIndex.value]),
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
    );
  }
}
