import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';

import 'package:hvdc_user/controllers/cart_controller.dart';
import 'package:hvdc_user/controllers/packages_controller.dart';
import 'package:hvdc_user/utils/loading.dart';
import '../controllers/homepage_controller.dart';
import '../controllers/tests_controller.dart';
import '../models/test.dart';
import '../utils/card.dart';
import '../utils/colors.dart';
import '../utils/style.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TestsController testsController = Get.put(TestsController());

  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: const Icon(
                      Icons.arrow_back,
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  Container(
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
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: SizedBox(
                        height: 100,
                        width: Get.width - 110,
                        child: TextField(
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
                          onChanged: (value) {
                            if (value.length > 2) {
                              testsController.getTestsSearch(key: value);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // const SizedBox(height: 30),
              // kContainer(
              //   child: Padding(
              //     padding: const EdgeInsets.all(10.0),
              //     child: ListView.builder(
              //       itemCount: 5,
              //       shrinkWrap: true,
              //       physics: const ScrollPhysics(),
              //       itemBuilder: (BuildContext context, int index) {
              //         return Padding(
              //           padding: const EdgeInsets.symmetric(vertical: 5.0),
              //           child: Row(
              //             children: [
              //               const Icon(
              //                 CupertinoIcons.search,
              //                 size: 20,
              //               ),
              //               const SizedBox(
              //                 width: 7,
              //               ),
              //               Text(
              //                 "Vitamin C Chewable Tablet",
              //                 style: kTextStyle.copyWith(
              //                     fontSize: 16,
              //                     color: kText,
              //                     fontWeight: FontWeight.w300),
              //               )
              //             ],
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ),
              const SizedBox(height: 20),

              Obx(
                () => testsController.isLoadingSearch.value
                    ? const KLoadingCircular()
                    : ListView.builder(
                        itemCount: testsController.testsSearch.length,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          Test test = testsController.testsSearch[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: kContainer(
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 15,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            test.name,
                                            style: kTextStyle.copyWith(
                                                fontSize: 16,
                                                color: kText,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            test.description,
                                            style: kTextStyle.copyWith(
                                              fontSize: 14,
                                              color: kText,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            maxLines: 1,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "₹ ${test.price}",
                                                style: kTextStyle.copyWith(
                                                    fontSize: 16,
                                                    color: kGreen,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "₹ ${test.regularPrice}",
                                                style: kTextStyle.copyWith(
                                                  fontSize: 12,
                                                  color: kGrey.withOpacity(0.7),
                                                  fontWeight: FontWeight.w600,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationColor:
                                                      kGrey.withOpacity(0.7),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Align(
                                          alignment: Alignment.bottomCenter,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                test.inCart = true;
                                              });
                                              cartController.addToCart(
                                                  test: test.id);
                                            },
                                            icon: const Icon(Icons.add),
                                          )),
                                    ],
                                  )),
                              height: 100,
                              width: double.infinity,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
