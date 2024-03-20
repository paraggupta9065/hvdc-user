import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:hvdc_user/utils/colors.dart';

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
              "assets/logo.png",
            ),
          ),
        ),
        const SizedBox(height: 50),
        InkWell(
          onTap: () {
            context.push("/home");
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
      ],
    ));
  }
}
