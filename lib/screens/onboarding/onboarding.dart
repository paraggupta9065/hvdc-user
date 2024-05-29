import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import 'package:hvdc_user/controllers/onboarding.dart';
import 'package:hvdc_user/utils/colors.dart';

import '../../utils/routing.dart';
import '../../utils/style.dart';

class Onbording extends StatefulWidget {
  const Onbording({super.key});

  @override
  State<Onbording> createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  OnboardingController onboardingController = Get.put(OnboardingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: PageView(
                controller: onboardingController.pageController,
                children: [
                  page1(),
                  page2(),
                  page3(),
                ],
              ),
            ),
            Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => DotsIndicator(
                        dotsCount: 3,
                        position: (onboardingController.page.value),
                        decorator: DotsDecorator(
                          size: const Size.square(8.0),
                          activeColor: kGreen,
                          activeSize: const Size(40.0, 8.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kGreen),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)))),
                      ),
                      onPressed: () => onboardingController.nextPage(),
                      child: const SizedBox(
                        height: 40,
                        width: double.maxFinite,
                        child: Center(
                          child: Text(
                            "Next",
                            style: TextStyle(
                              color: kWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.toNamed("/sign-up");
                        },
                        child: SizedBox(
                          height: 40,
                          width: double.maxFinite,
                          child: Center(
                            child: Text(
                              "Skip",
                              style: kTextStyle.copyWith(color: kGreen),
                            ),
                          ),
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Column page1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image.asset(
              "assets/onboarding/onboarding1.png",
              height: 200,
            ),
            Image.asset(
              "assets/onboarding/background.png",
              height: 300,
              width: 300,
            ),
          ],
        ),
        const SizedBox(height: 80),
        const Text(
          """Health checks &\nconsultations easily\nanywhere anytime""",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kGreen,
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Column page2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image.asset(
              "assets/onboarding/onboarding1.png",
              height: 200,
            ),
            Image.asset(
              "assets/onboarding/background.png",
              height: 300,
              width: 300,
            ),
          ],
        ),
        const SizedBox(height: 80),
        const Text(
          """Thousands of\ndoctors & experts to\nhelp your health!""",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kGreen,
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Column page3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image.asset(
              "assets/onboarding/onboarding1.png",
              height: 200,
            ),
            Image.asset(
              "assets/onboarding/background.png",
              height: 300,
              width: 300,
            ),
          ],
        ),
        const SizedBox(height: 80),
        const Text(
          """Let’s start living\nhealthy and well\nwith us right now!""",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kGreen,
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
