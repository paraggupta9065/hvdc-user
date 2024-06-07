import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:hvdc_user/controllers/cart_controller.dart';
import 'package:hvdc_user/utils/card.dart';
import 'package:hvdc_user/utils/responsive.dart';
import 'package:hvdc_user/utils/style.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/homepage_controller.dart';
import '../../models/category.dart';
import '../../models/packages.dart';
import '../../utils/colors.dart';
import '../../utils/padding.dart';
import '../../utils/routing.dart';
import '../../utils/urls.dart';
import 'footer.dart';
import 'header.dart';

class WebHome extends StatefulWidget {
  const WebHome({super.key});

  @override
  State<WebHome> createState() => _WebHomeState();
}

class _WebHomeState extends State<WebHome> {
  final HomepageController homepageController = Get.put(HomepageController());
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreenOpacity,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(),
            const SizedBox(height: 50),
            Banner(),
            const SizedBox(height: 50),
            testsCard(),
            const SizedBox(height: 30),
            packagesTitle(),
            const SizedBox(height: 20),
            packages(),
            const SizedBox(height: 50),
            Padding(
              padding: kWebPadding,
              child: const UploadPrescription(),
            ),
            const SizedBox(height: 50),
            callUs(),
            const SizedBox(height: 50),
            whyChooseUs(),
            const SizedBox(height: 50),
            testimonials(),
            const SizedBox(height: 50),
            Footer(),
            const SizedBox(height: 0),
          ],
        ),
      ),
    );
  }

  Widget testimonials() {
    return Padding(
      padding: kWebPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Real Stories,",
                    style: kTextStyle.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      color: kText,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: kGreenOpacity,
                        ),
                        child: const Center(
                          child: Icon(Icons.people),
                        ),
                      ),
                      Text(
                        "Our Testimonials",
                        style: kTextStyle.copyWith(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: kText,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "What Our Readers Say",
                    style: kTextStyle.copyWith(
                      fontSize: 27,
                      fontWeight: FontWeight.w500,
                      color: kText,
                    ),
                  ),
                  Text(
                    "Don't just take our word for it. See what our readers have to say about their experiences\nwith HVDC.",
                    style: kTextStyle.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                      color: kText,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              kContainer(
                  height: 320,
                  width: kWidth(27),
                  color: const Color(0xFFF5F8FA),
                  child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: kGreen,
                                      borderRadius: BorderRadius.circular(300)),
                                  child: const Text(""),
                                ),
                                SizedBox(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 80),
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              color: kWhite,
                                              borderRadius:
                                                  BorderRadius.circular(300)),
                                          child: const Text(""),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Neha".toUpperCase(),
                                  style: kTextStyle.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: kText,
                                  ),
                                ),
                                Text(
                                  "Delhi",
                                  style: kTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: kText,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Booking tests was a breeze with Indian Pathology Test Booking Site! From selecting tests to scheduling appointments, everything was seamless. Quick turnaround for results was a bonus. Highly recommend!",
                          style: kTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: kText,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )),
              kContainer(
                  height: 320,
                  width: kWidth(27),
                  color: const Color(0xFFF5F8FA),
                  child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: kGreen,
                                      borderRadius: BorderRadius.circular(300)),
                                  child: const Text(""),
                                ),
                                SizedBox(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 80),
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              color: kWhite,
                                              borderRadius:
                                                  BorderRadius.circular(300)),
                                          child: const Text(""),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rajesh".toUpperCase(),
                                  style: kTextStyle.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: kText,
                                  ),
                                ),
                                Text(
                                  "Delhi",
                                  style: kTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: kText,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Indian Pathology Test Booking Site made my life easier! I could easily find nearby labs, book appointments, and get accurate results in no time. Convenient and reliable service. Will use again!",
                          style: kTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: kText,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )),
              kContainer(
                  height: 320,
                  width: kWidth(27),
                  color: const Color(0xFFF5F8FA),
                  child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: kGreen,
                                      borderRadius: BorderRadius.circular(300)),
                                  child: const Text(""),
                                ),
                                SizedBox(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 80),
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              color: kWhite,
                                              borderRadius:
                                                  BorderRadius.circular(300)),
                                          child: const Text(""),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Priya".toUpperCase(),
                                  style: kTextStyle.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: kText,
                                  ),
                                ),
                                Text(
                                  "Delhi",
                                  style: kTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: kText,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Using Indian Pathology Test Booking Site was a great decision! It saved me time and effort by allowing me to book tests online hassle-free. The platform is efficient, and the labs are trustworthy. Definitely recommend it!",
                          style: kTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: kText,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }

  Column whyChooseUs() {
    return Column(
      children: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Why Choose Us",
                style: kTextStyle.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  color: kText,
                ),
              ),
              Text(
                "Our satisfied clients share their success stories and experiences on their journey to better health and\nwell-being.",
                style: kTextStyle.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                  color: kText,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: kWebPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              kContainer(
                  height: 300,
                  width: kWidth(27),
                  color: const Color(0xFFFFD6EF),
                  child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          "assets/why-1.png",
                          height: 70,
                        ),
                        Column(
                          children: [
                            Text(
                              "100% Safe & hygienic".toUpperCase(),
                              style: kTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: kText,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Expereince hassle free healthcare with online test booking",
                              style: kTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: kText,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              kContainer(
                  height: 300,
                  width: kWidth(27),
                  color: const Color(0xFFFEC091),
                  child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          "assets/why-2.png",
                          height: 70,
                        ),
                        Column(
                          children: [
                            Text(
                              "home pickup sample".toUpperCase(),
                              style: kTextStyle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: kText,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Expereince hassle free healthcare with online test booking",
                              style: kTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: kText,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              kContainer(
                height: 300,
                width: kWidth(27),
                color: const Color(0xFFFFD6EF),
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        "assets/why-3.png",
                        height: 70,
                      ),
                      Column(
                        children: [
                          Text(
                            "view reports online".toUpperCase(),
                            style: kTextStyle.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: kText,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Expereince hassle free healthcare with online test booking",
                            style: kTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: kText,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Padding packagesTitle() {
    return Padding(
      padding: kWebPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "health check-up packages".toUpperCase(),
            style: kTextStyle.copyWith(color: kText, fontSize: 40),
          ),
        ],
      ),
    );
  }

  Obx packages() {
    return Obx(
      () => homepageController.packagesController.isLoadingPackages.value
          ? const SizedBox()
          : Padding(
              padding: kWebPadding,
              child: SizedBox(
                width: kWidth(100) - 300,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount:
                      homepageController.packagesController.packages.length,
                  itemBuilder: (BuildContext context, int index) {
                    Packages packages =
                        homepageController.packagesController.packages[index];
                    return kContainer(
                        color: const Color(0xFFF5F8FA),
                        child: Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        packages.name,
                                        style: kTextStyle.copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      kContainer(
                                          color: const Color(0xFFF5F8FA),
                                          height: 60,
                                          width: 60,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                packages.tests.length
                                                    .toString(),
                                              ),
                                              const Text("Tests"),
                                            ],
                                          ))
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  const Divider(),
                                  const SizedBox(height: 10),
                                  RichText(
                                    text: TextSpan(
                                        text: "Tests Included:",
                                        style: kTextStyle.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                        children: [
                                          for (PackageTest i in packages.tests)
                                            TextSpan(
                                              text: packages.tests.last == i
                                                  ? " ${i.name}"
                                                  : " ${i.name},",
                                              style: kTextStyle.copyWith(
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                        ]),
                                  ),
                                  const SizedBox(height: 10),
                                  RichText(
                                    text: TextSpan(
                                        text: "Description: ",
                                        style: kTextStyle.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: packages.description,
                                            style: kTextStyle.copyWith(
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ]),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.peopleGroup,
                                        color: kGreen,
                                        size: 12,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        packages.gender,
                                        style: kTextStyle.copyWith(
                                            fontSize: 15,
                                            color: kText,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.clock,
                                        color: kGreen,
                                        size: 12,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        packages.reportTime,
                                        style: kTextStyle.copyWith(
                                            fontSize: 15,
                                            color: kText,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.baby,
                                        color: kGreen,
                                        size: 15,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        packages.age,
                                        style: kTextStyle.copyWith(
                                            fontSize: 15,
                                            color: kText,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(kGreen),
                                  shape: MaterialStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)))),
                                ),
                                onPressed: () {
                                  cartController.addToCart(
                                      package: packages.id);
                                },
                                child: SizedBox(
                                  height: 40,
                                  width: double.maxFinite,
                                  child: Center(
                                    child: Text(
                                      "Add to cart",
                                      style: kTextStyle.copyWith(color: kWhite),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                  },
                ),
              ),
            ),
    );
  }

  Padding testsCard() {
    return Padding(
      padding: kWebPadding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => homepageController.isLoading.value
                ? const SizedBox()
                : SizedBox(
                    width: kWidth(100) - 300,
                    height: 160,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        childAspectRatio: 2,
                      ),
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        Category category =
                            homepageController.categories[index];

                        return InkWell(
                          onTap: () {
                            Get.toNamed(
                                "/tests?category_id=${category.id}&category_name=${category.categoryName}");
                          },
                          child: Container(
                              height: 160,
                              padding: const EdgeInsets.all(20),
                              margin: const EdgeInsets.all(5),
                              decoration: ShapeDecoration(
                                color: (index % 2) == 0
                                    ? const Color(0xFFFEC091)
                                    : const Color(0xFFFFD6EF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        category.categoryName.toUpperCase(),
                                        style: kTextStyle.copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.all(5),
                                        decoration: ShapeDecoration(
                                          color: kBlack,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(200),
                                            ),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.arrow_outward_outlined,
                                          color: kWhite,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Expanded(child: SizedBox()),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/home-b1.png",
                                        height: 50,
                                      )
                                    ],
                                  )
                                ],
                              )),
                        );
                      },
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
      padding: const EdgeInsets.symmetric(horizontal: 13.0),
      child: Text(title,
          style:
              kTextStyle.copyWith(color: kText, fontWeight: FontWeight.w700)),
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
                    "HVDC FULL BODY CHECKUP At ₹299".toUpperCase(),
                    textAlign: TextAlign.justify,
                    style: kTextStyle.copyWith(
                      color: kText,
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
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
                decoration: const BoxDecoration(color: kWhite),
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

Padding callUs() {
  return Padding(
    padding: kWebPadding,
    child: kContainer(
      color: const Color(0xFF373737),
      height: 200,
      width: kMobile ? kWidth(100) : kWidth(100) - 300,
      child: Padding(
        padding: kMobile
            ? const EdgeInsets.only(right: 10, left: 10)
            : const EdgeInsets.only(right: 35, left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Need help with booking your test?",
                      style: kTextStyle.copyWith(
                        fontSize: kMobile ? 17 : 32,
                        fontWeight: FontWeight.w400,
                        color: kWhite,
                      ),
                    ),
                    Text(
                      "Contact our support to order your tests",
                      style: kTextStyle.copyWith(
                        fontSize: kMobile ? 12 : 20,
                        fontWeight: FontWeight.w300,
                        color: kWhite,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kWhite),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                launchUrl(Uri.parse("tel:+1-212-555-1234"));
              },
              child: SizedBox(
                height: kMobile ? 30 : 40,
                child: Center(
                  child: Text(
                    "Call Now",
                    style: TextStyle(
                      color: kText,
                      fontSize: kMobile ? 15 : 20,
                      fontWeight: FontWeight.w500,
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

class UploadPrescription extends StatelessWidget {
  const UploadPrescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed('/upload_prescription');
      },
      child: Container(
        height: kWeb ? 150 : 100,
        decoration: ShapeDecoration(
          color: kGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(color: kOpacity),
              child: const Icon(
                FontAwesomeIcons.image,
                color: kWhite,
              ),
            ),
            const Spacer(flex: 1),
            const Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upload Prescription',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 20,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Lorem Ipsum',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 14,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ],
            ),
            const Spacer(flex: 20),
            Container(
              height: 35,
              width: 80,
              decoration: ShapeDecoration(
                color: kWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Center(
                child: Text(
                  'Upload',
                  style: TextStyle(
                    color: kGreen,
                    fontSize: 14,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
