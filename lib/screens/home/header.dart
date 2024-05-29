import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/utils/card.dart';

import 'package:overlay_search/overlay_search.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/tests_controller.dart';
import '../../models/test.dart';
import '../../utils/colors.dart';
import '../../utils/padding.dart';
import '../../utils/responsive.dart';
import '../../utils/routing.dart';
import '../../utils/style.dart';
import 'web_home.dart';

class Header extends StatelessWidget {
  Header({
    super.key,
  });
  final AuthController authController = Get.put(AuthController());
  final CartController cartController = Get.put(CartController());
  final TestsController testsController = Get.put(TestsController());
  OverlaySearchController overlaySearchController = OverlaySearchController();
  late bool isLogin = authController.isLogin();

  @override
  Widget build(BuildContext context) {
    testsController.testsSearch = [];
    return Container(
      color: kWhite,
      child: kWeb
          ? Padding(
              padding: kWebPadding.copyWith(top: 20, bottom: 20),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      height: 70,
                      width: kWidth(10),
                      "assets/logo2.png",
                      fit: BoxFit.cover,
                    ),
                    const Spacer(flex: 1),
                    InkWell(
                      onTap: () {
                        launchUrl(Uri.parse("tel:+1-212-555-1234"));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Call Us",
                              style: kTextStyle.copyWith(
                                  color: kText, fontSize: 15)),
                          Text("+91 706537 6565",
                              style: kTextStyle.copyWith(color: kText)),
                        ],
                      ),
                    ),
                    const Spacer(flex: 1),
                    Obx(
                      () => Container(
                        height: 50,
                        width: kWidth(20),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SearchWithList(
                          overlaySearchController: overlaySearchController,
                          list: testsController.isLoadingSearch.value
                              ? []
                              : testsController.testsSearch
                                  .map(
                                    (e) => OverlayItemModel(
                                      title: e.name,
                                      content: "₹ ${e.price}",
                                      id: e.id.toString(),
                                    ),
                                  )
                                  .toList(),
                          isLoading: testsController.isLoadingSearch.value,
                          hintStyle: kTextStyle,
                          overlayBackgroundColor: Colors.white,
                          hint: "Find your test ",
                          suffixAction: () {},
                          notFoundText: "Find your test ",
                          onItemSelected: (item) {
                            Test test = testsController.testsSearch.firstWhere(
                              (element) => '${element.id}' == item.id,
                            );
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                        content: SizedBox(
                                      height: 300,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 15,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      test.name,
                                                      style:
                                                          kTextStyle.copyWith(
                                                              fontSize: 16,
                                                              color: kText,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          FontAwesomeIcons
                                                              .spoon,
                                                          color: kGreen,
                                                          size: 12,
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Text(
                                                          test.fasting,
                                                          style: kTextStyle
                                                              .copyWith(
                                                                  fontSize: 12,
                                                                  color: kText,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 3),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          FontAwesomeIcons
                                                              .peopleGroup,
                                                          color: kGreen,
                                                          size: 12,
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Text(
                                                          test.gender,
                                                          style: kTextStyle
                                                              .copyWith(
                                                                  fontSize: 12,
                                                                  color: kText,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 3),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          FontAwesomeIcons
                                                              .clock,
                                                          color: kGreen,
                                                          size: 12,
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Text(
                                                          test.reportTime,
                                                          style: kTextStyle
                                                              .copyWith(
                                                                  fontSize: 12,
                                                                  color: kText,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
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
                                                        const SizedBox(
                                                            width: 10),
                                                        Text(
                                                          test.age,
                                                          style: kTextStyle
                                                              .copyWith(
                                                                  fontSize: 12,
                                                                  color: kText,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          "₹ ${test.price}",
                                                          style: kTextStyle
                                                              .copyWith(
                                                                  fontSize: 16,
                                                                  color: kGreen,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Text(
                                                          "₹ ${test.regularPrice}",
                                                          style: kTextStyle
                                                              .copyWith(
                                                            fontSize: 12,
                                                            color: kGrey
                                                                .withOpacity(
                                                                    0.7),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            decorationColor:
                                                                kGrey
                                                                    .withOpacity(
                                                                        0.7),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Visibility(
                                              visible: true,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child:
                                                        Text(test.description),
                                                  )),
                                            ),
                                            test.inCart
                                                ? TextButton(
                                                    onPressed: () {},
                                                    child: Text(
                                                      "Remove from cart",
                                                      style:
                                                          kTextStyle.copyWith(
                                                              color: kGreen),
                                                    ),
                                                  )
                                                : TextButton(
                                                    onPressed: () {
                                                      cartController.addToCart(
                                                          test: test.id);
                                                    },
                                                    child: Text(
                                                      "Add to cart",
                                                      style:
                                                          kTextStyle.copyWith(
                                                              color: kGreen),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    )));
                          },
                          onChanged: (value) async {
                            if (value.length > 2) {
                              await testsController.getTestsSearch(key: value);
                              overlaySearchController.searchFocusNode
                                  .requestFocus();
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: kWidth(33),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
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
                              launchUrl(Uri.parse("https://hvdc.in/blog/"));
                            },
                            child: const NavbarItem('Articles'),
                          ),
                          InkWell(
                            onTap: () {
                              launchUrl(Uri.parse("https://hvdc.in/about/"));
                            },
                            child: const NavbarItem('About Us'),
                          ),
                          if (!isLogin)
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
                                Get.toNamed("/sign-up");
                              },
                              child: SizedBox(
                                height: 40,
                                width: 60,
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: kTextStyle.copyWith(color: kWhite),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          authController.user?.profilePic ??
                                              "https://www.belizeplanners.org/wp-content/uploads/2016/01/male-placeholder.jpg",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hello ${authController.user?.name}',
                                        style: const TextStyle(
                                          color: Color(0x99666666),
                                          fontSize: 16,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Your health is our priority',
                                        style: TextStyle(
                                          color: kText,
                                          fontSize: 14,
                                          fontFamily: 'Raleway',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed("/notification");
                                    },
                                    child: const Icon(
                                      CupertinoIcons.bell,
                                      color: kGreen,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Obx(
                                    () => Badge.count(
                                      count: (cartController.cart?.cart.tests ??
                                              [])
                                          .length,
                                      isLabelVisible:
                                          !cartController.isLoadingCart.value,
                                      child: InkWell(
                                        onTap: () {
                                          Get.toNamed("/cart");
                                        },
                                        child: const Icon(
                                          CupertinoIcons.shopping_cart,
                                          color: kGreen,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: () {
                    Get.toNamed("/search");
                  },
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: kWhite,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFFE8E8E8)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: kText.withOpacity(.5),
                          fontSize: 14,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w400,
                          height: 0,
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
