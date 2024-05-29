import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/utils/appBar.dart';
import 'package:hvdc_user/utils/colors.dart';
import 'package:hvdc_user/utils/loading.dart';
import 'package:hvdc_user/utils/responsive.dart';
import 'package:hvdc_user/utils/style.dart';
import 'package:wordpress_client/wordpress_client.dart';

import '../controllers/article_controller.dart';
import '../controllers/cart_controller.dart';
import '../models/test.dart';
import 'card.dart';

class Article extends StatefulWidget {
  const Article({super.key, required this.id});
  final int id;

  @override
  State<Article> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Article> {
  final ArticleController articleController = Get.put(ArticleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar("Article"),
      body: SafeArea(
        child: FutureBuilder(
          future: articleController.getPost(id: widget.id),
          builder: (BuildContext context, AsyncSnapshot<Post> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: KLoading());
            }

            Post post = snapshot.data!;
            articleController.client.tags
                .list(
              ListTagRequest(include: post.categories),
            )
                .then(
              (value) {
                List<Tag> tags = value.asSuccess().data;

                if (tags.isEmpty) {
                  articleController.getTestsRecommendation(key: "Blood Test");
                } else {
                  Tag tag = tags[0];
                  articleController.getTestsRecommendation(
                      key: tag.name ?? "Blood Test");
                }
              },
            );

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title?.parsedText ?? "",
                      style: kTextStyle.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    Image.network(
                      post.featuredImageUrl ?? "",
                      width: kWidth(100),
                      fit: BoxFit.cover,
                    ),
                    Text(
                      (post.content?.parsedText ?? "")
                          .replaceAll('\n\n', '\n')
                          .toString(),
                      style: kTextStyle,
                    ),
                    Text(
                      "Recommendations",
                      style: kTextStyle.copyWith(
                        fontSize: 20,
                        color: kText,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => articleController.isLoadingRecommendation.value
                          ? const SizedBox()
                          : ListView.builder(
                              itemCount:
                                  articleController.recommendationSearch.length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                Test test = articleController
                                    .recommendationSearch[index];

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: listTestTile(test, index),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
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
