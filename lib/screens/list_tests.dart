import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:hvdc_user/controllers/tests_controller.dart';
import 'package:hvdc_user/models/test.dart';
import 'package:hvdc_user/utils/appBar.dart';
import '../controllers/cart_controller.dart';
import '../utils/card.dart';
import '../utils/colors.dart';
import '../utils/loading.dart';
import '../utils/style.dart';
import 'dart:math' as math;

import 'home/mobile_home.dart';

class ListTests extends StatefulWidget {
  const ListTests(
      {super.key, required this.categoryId, required this.categoryName});
  final String categoryId;
  final String categoryName;

  @override
  State<ListTests> createState() => _ListTestsState();
}

class _ListTestsState extends State<ListTests> {
  TestsController testsController = Get.put(TestsController());
  @override
  void initState() {
    testsController.getTests(categoryId: widget.categoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: KAppBar(widget.categoryName),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(
            () => testsController.isLoadingTests.value
                ? const Center(
                    child: KLoading(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        ListView.builder(
                          itemCount: testsController.tests.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            Test test = testsController.tests[index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Obx(() {
                                return listTestTile(test, index);
                              }),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BottomCartWidth(isLoading: testsController.isLoadingTests),
        ),
      ),
    );
  }

  Container listTestTile(Test test, int index) {
    CartController cartController = Get.put(CartController());
    bool isOpen = testsController.openIndex.value == index;

    return kContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      test.name,
                      style: kTextStyle.copyWith(
                          fontSize: 16,
                          color: kText,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.spoon,
                          color: kGreen,
                          size: 12,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          test.fasting,
                          style: kTextStyle.copyWith(
                              fontSize: 12,
                              color: kText,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.peopleGroup,
                          color: kGreen,
                          size: 12,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          test.gender,
                          style: kTextStyle.copyWith(
                              fontSize: 12,
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
                          test.reportTime,
                          style: kTextStyle.copyWith(
                              fontSize: 12,
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
                          test.age,
                          style: kTextStyle.copyWith(
                              fontSize: 12,
                              color: kText,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "₹ ${test.price}",
                          style: kTextStyle.copyWith(
                              fontSize: 16,
                              color: kGreen,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "₹ ${test.regularPrice}",
                          style: kTextStyle.copyWith(
                            fontSize: 12,
                            color: kGrey.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: kGrey.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    isOpen
                        ? testsController.openIndex.value =
                            double.maxFinite.toInt()
                        : testsController.openIndex.value = index;
                  },
                  icon: Transform.rotate(
                    angle: isOpen ? math.pi / 2 : -math.pi / 2,
                    child: const Icon(
                      Icons.arrow_back_ios_sharp,
                      size: 17,
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: isOpen,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(test.description),
              ),
            ),
            test.inCart
                ? TextButton(
                    onPressed: () {
                      setState(() {
                        test.inCart = false;
                      });
                      cartController.removeFromCart(test.id);
                    },
                    child: Text(
                      "Remove from cart",
                      style: kTextStyle.copyWith(color: kGreen),
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      setState(() {
                        test.inCart = true;
                      });
                      cartController.addToCart(test: test.id);
                    },
                    child: Text(
                      "Add to cart",
                      style: kTextStyle.copyWith(color: kGreen),
                    ),
                  ),
          ],
        ),
      ),
      width: double.infinity,
    );
  }
}
