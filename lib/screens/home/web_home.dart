import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/utils/responsive.dart';
import 'package:hvdc_user/utils/style.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/homepage_controller.dart';
import '../../utils/colors.dart';
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
      body: Column(
        children: [
          Header(),
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
    return SizedBox(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Image.asset(
              height: 70,
              width: kWidth(10),
              "assets/logo2.png",
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 20,
              ),
              SizedBox(width: kWidth(.5)),
              Text(
                "Select Location",
                style: kTextStyle.copyWith(color: kGrey),
              ),
              SizedBox(width: kWidth(.5)),
              const Icon(
                Icons.keyboard_arrow_down,
                size: 20,
              ),
            ],
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
    );
  }
}

class NavbarItem extends StatelessWidget {
  final String title;

  const NavbarItem(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(title,
          style:
              kTextStyle.copyWith(color: kGreen, fontWeight: FontWeight.w700)),
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
    return Stack(
      children: [
        SizedBox(
          height: 180,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ListView.builder(
              itemCount: homepageController.banners.length,
              itemBuilder: (context, index) => SizedBox(
                width: double.infinity,
                height: 180,
                child: Image.network(
                  baseUrl + homepageController.banners[index].image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        // SizedBox(
        //   height: 170,
        //   child: Align(
        //     alignment: Alignment.bottomCenter,
        //     child: DotsIndicator(
        //       dotsCount: 3,
        //       position: 0,
        //       decorator: DotsDecorator(
        //         size: const Size.square(8.0),
        //         activeColor: kGreen,
        //         activeSize: const Size(40.0, 8.0),
        //         activeShape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(5.0)),
        //       ),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
