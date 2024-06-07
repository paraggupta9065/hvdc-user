import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hvdc_user/controllers/article_controller.dart';
import 'package:hvdc_user/utils/colors.dart';
import 'package:hvdc_user/utils/date_parser.dart';
import 'package:hvdc_user/utils/style.dart';
import 'package:wordpress_client/wordpress_client.dart';

import 'loading.dart';

class Articles extends StatefulWidget {
  const Articles({super.key});

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
  final ArticleController articleController = Get.put(ArticleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Articles',
                          style: TextStyle(
                            color: kText,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              Obx(() => articleController.isLoading.value
                  ? const Center(
                      child: KLoading(),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SizedBox(
                            width: Get.width,
                            height: 50,
                            child: ListView.builder(
                              itemCount: articleController.categories.length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Obx(() => InkWell(
                                      onTap: () {
                                        articleController.selectedIndex.value =
                                            index;

                                        articleController.getPosts();
                                        setState(() {});
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: kGreen,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: articleController
                                                      .selectedIndex.value ==
                                                  index
                                              ? kGreen
                                              : kWhite,
                                        ),
                                        margin:
                                            const EdgeInsets.only(right: 16),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Center(
                                          child: Text(
                                            articleController
                                                    .categories[index].name ??
                                                "",
                                            style: TextStyle(
                                              color: articleController
                                                          .selectedIndex
                                                          .value !=
                                                      index
                                                  ? kGreen
                                                  : kWhite,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          ),
                        ),
                        ListView.builder(
                          itemCount: articleController.posts.length > 3
                              ? 3
                              : articleController.posts.length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemBuilder: (BuildContext context, int index) {
                            Post post = articleController.posts[index];
                            return InkWell(
                              onTap: () => Get.toNamed(
                                "/article/${post.id}",
                              ),
                              child: ArticleTile(
                                post: post,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Trending',
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '',
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 14,
                                  ),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SizedBox(
                            width: Get.width,
                            height: 200,
                            child: ListView.builder(
                              itemCount: articleController.trandingPosts.length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () => Get.toNamed(
                                    "/article/${articleController.trandingPosts[index].id}",
                                  ),
                                  child: ArticleCard(
                                    post:
                                        articleController.trandingPosts[index],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    )),
            ],
          ),
        ),
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 130,
              width: 220,
              decoration: BoxDecoration(
                color: kGreen,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.network(
                post.featuredImageUrl ??
                    "https://www.trschools.com/templates/imgs/default_placeholder.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 220,
            child: Text(
              post.title?.parsedText ?? "",
              style: kTextStyle.copyWith(fontSize: 16),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class ArticleTile extends StatelessWidget {
  const ArticleTile({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 110,
              width: 110,
              decoration: const BoxDecoration(color: kGreen),
              child: Image.network(
                post.featuredImageUrl ??
                    "https://www.trschools.com/templates/imgs/default_placeholder.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  dateParser(
                    (post.date ?? DateTime.now()),
                  ),
                  style: kTextStyle.copyWith(fontSize: 12),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    post.title?.parsedText ?? "",
                    style: kTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    post.content?.parsedText ?? "",
                    maxLines: 1,
                    style: kTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
