import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/utils/responsive.dart';
import 'package:hvdc_user/utils/style.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/homepage_controller.dart';
import '../../utils/colors.dart';
import '../../utils/padding.dart';
import '../../utils/urls.dart';

class WebHome extends StatefulWidget {
  const WebHome({super.key});

  @override
  State<WebHome> createState() => _WebHomeState();
}

class _WebHomeState extends State<WebHome> {
  final HomepageController homepageController = Get.put(HomepageController());

  @override
  void initState() {
    homepageController.initHomepage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreenOpacity,
      body: Column(
        children: [
          Header(),
          const SizedBox(height: 50),
          Banner(),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  Header({
    super.key,
  });
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhite,
      child: Padding(
        padding: kWebPadding.copyWith(top: 20, bottom: 20),
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                height: 50,
                width: kWidth(10),
                "assets/logo2.png",
                fit: BoxFit.cover,
              ),
              // Row(
              //   children: [
              //     const Icon(
              //       Icons.location_on_outlined,
              //       size: 20,
              //     ),
              //     SizedBox(width: kWidth(.5)),
              //     Text(
              //       "Select Location",
              //       style: kTextStyle.copyWith(color: kGrey),
              //     ),
              //     SizedBox(width: kWidth(.5)),
              //     const Icon(
              //       Icons.keyboard_arrow_down,
              //       size: 20,
              //     ),
              //   ],
              // ),
              const Spacer(
                flex: 1,
              ),
              SizedBox(
                width: kWidth(2),
              ),
              Container(
                height: 50,
                width: kWidth(20),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: kWhite,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: kGrey.withOpacity(.4)),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.search,
                        size: 30, color: kGrey.withOpacity(.4)),
                    SizedBox(width: kWidth(1)),
                    Text(
                      "Search",
                      style: kTextStyle.copyWith(color: kGrey.withOpacity(.4)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: kWidth(30),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NavbarItem('About'),
                    NavbarItem('Team'),
                    NavbarItem('Process'),
                    NavbarItem('Healthcare Services'),
                    NavbarItem('Offers'),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kGreen),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)))),
                ),
                child: SizedBox(
                  height: 40,
                  width: kWidth(10),
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
            ],
          ),
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
          style: kTextStyle.copyWith(
              color: kGreenOpacityDark, fontWeight: FontWeight.w700)),
    );
  }
}

class Banner extends StatelessWidget {
  Banner({
    super.key,
  });
  final HomepageController homepageController = Get.put(HomepageController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kWebPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: kWidth(32),
                  child: Text(
                    "family body checkup package now at ₹240".toUpperCase(),
                    textAlign: TextAlign.justify,
                    style: kTextStyle.copyWith(
                      color: kText,
                      fontWeight: FontWeight.w700,
                      fontSize: 48,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: kWidth(32),
                  child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: kGreen),
                                borderRadius: BorderRadius.circular(100)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                "assets/app_icons/stars.svg",
                                semanticsLabel: 'Acme Logo',
                                color: kGreen,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "full body checkup".toUpperCase(),
                            textAlign: TextAlign.justify,
                            style: kTextStyle.copyWith(
                              color: kText,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: kGreen),
                                borderRadius: BorderRadius.circular(100)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                "assets/app_icons/stars.svg",
                                semanticsLabel: 'Acme Logo',
                                color: kGreen,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "free home sample pickup".toUpperCase(),
                            textAlign: TextAlign.justify,
                            style: kTextStyle.copyWith(
                              color: kText,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                height: 650,
                width: 700,
                decoration: BoxDecoration(color: kWhite),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/web_banner/1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                                top: 10,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Image.asset(
                                    'assets/web_banner/1.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                                bottom: 10,
                                top: 10,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Image.asset(
                                    'assets/web_banner/1.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
