import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import 'package:hvdc_user/utils/routing.dart';

class OnboardingController extends GetxController {
  PageController pageController = PageController();
  RxInt page = 0.obs;

  nextPage() {
    if (page.value != 2) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 700), curve: Curves.ease);
      page.value = (pageController.page!).toInt();
      page.value++;
    } else {
      Get.toNamed("/sign-up");
    }
  }
}
