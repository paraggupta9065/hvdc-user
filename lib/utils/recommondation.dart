import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/utils/card.dart';
import 'package:hvdc_user/utils/style.dart';

import '../controllers/article_controller.dart';
import '../controllers/cart_controller.dart';
import '../models/test.dart';
import 'appBar.dart';
import 'colors.dart';
import 'responsive.dart';

class Recommendation extends StatefulWidget {
  const Recommendation({super.key});

  @override
  State<Recommendation> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  final ArticleController articleController = Get.put(ArticleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kWeb ? null : KAppBar("Recommendation"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
          () => articleController.isLoadingRecommendation.value
              ? const SizedBox()
              : ListView.builder(
                  itemCount: articleController.recommendationSearch.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    Test test = articleController.recommendationSearch[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: listTestTile(test, index),
                    );
                  },
                ),
        ),
      ),
    );
  }

  Container listTestTile(Test test, int index) {
    CartController cartController = Get.put(CartController());
    bool isOpen = false;

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
