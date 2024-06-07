import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:hvdc_user/screens/home/web_home.dart';
import 'package:hvdc_user/utils/card.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/auth_controller.dart';
import '../../utils/colors.dart';
import '../../utils/padding.dart';
import '../../utils/responsive.dart';
import '../../utils/routing.dart';
import '../../utils/style.dart';

class Footer extends StatelessWidget {
  Footer({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    late bool isLogin = authController.isLogin();

    return Container(
      height: 190,
      width: kWidth(100),
      color: kText,
      child: Padding(
        padding: kWebPadding.copyWith(top: 60, bottom: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            kContainer(
              border: false,
              color: kWhite.withOpacity(0.3),
              height: 70,
              width: kWidth(100) - 300,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      height: 50,
                      width: kWidth(10),
                      "assets/logo3.png",
                      fit: BoxFit.cover,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed("/home");
                          },
                          child: const NavbarItem('Home'),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed("/cart");
                          },
                          child: const NavbarItem('Cart'),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed("/bookings");
                          },
                          child: const NavbarItem('Orders'),
                        ),
                        InkWell(
                          onTap: () {
                            launchUrl(Uri.parse("https://blog.hvdc.in/blog/"));
                          },
                          child: const NavbarItem('Articles'),
                        ),
                        InkWell(
                          onTap: () {
                            launchUrl(Uri.parse("https://blog.hvdc.in/about/"));
                          },
                          child: const NavbarItem('About Us'),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            launchUrl(Uri.parse(
                                "https://www.instagram.com/hvdc_info/"));
                          },
                          icon: const Icon(
                            FontAwesomeIcons.instagram,
                            color: kWhite,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            launchUrl(Uri.parse(
                                "https://www.facebook.com/profile.php?id=61559747606949"));
                          },
                          icon: const Icon(
                            FontAwesomeIcons.squareFacebook,
                            color: kWhite,
                          ),
                        ),
                      ],
                    ),
                    // InkWell(
                    //   onTap: () {},
                    //   child: const Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       // Text(
                    //       //   "Go To Top",
                    //       //   style: kTextStyle.copyWith(
                    //       //     fontSize: 15,
                    //       //     fontWeight: FontWeight.w400,
                    //       //     color: kText,
                    //       //   ),
                    //       // ),
                    //       // const SizedBox(
                    //       //   width: 10,
                    //       // ),
                    //       // CircleAvatar(
                    //       //   backgroundColor: kWhite.withOpacity(0.1),
                    //       //   child: Icon(
                    //       //     Icons.arrow_upward,
                    //       //     color: kText,
                    //       //   ),
                    //       // ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavbarItem extends StatelessWidget {
  final String title;

  const NavbarItem(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0),
      child: Text(title,
          style:
              kTextStyle.copyWith(color: kWhite, fontWeight: FontWeight.w500)),
    );
  }
}
