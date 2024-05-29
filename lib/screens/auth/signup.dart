import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import 'package:hvdc_user/controllers/auth_controller.dart';
import 'package:hvdc_user/utils/colors.dart';
import 'package:hvdc_user/utils/responsive.dart';

import '../../utils/routing.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(height: 250),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              height: 200,
              width: 200,
              "assets/logo.png",
            ),
          ),
        ),
        const SizedBox(height: 50),
        Padding(
          padding: kWeb
              ? const EdgeInsets.symmetric(horizontal: 500)
              : const EdgeInsets.symmetric(horizontal: 0),
          child: InkWell(
            onTap: () async {
              AuthController authController = Get.put(AuthController());
              await authController.login();
              Get.toNamed("/home");
            },
            child: Container(
              height: 50,
              width: Get.width - 40,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                border: Border.all(
                  width: 1.5,
                  color: kGreen,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      "assets/google.png",
                      height: 30,
                    ),
                    const Text(
                      "Sign in with Google",
                    ),
                    Image.asset(
                      "assets/arrow.png",
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
