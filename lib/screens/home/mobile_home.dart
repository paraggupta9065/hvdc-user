import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hvdc_user/models/pathlogy.dart';

import '../../controllers/article_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/homepage_controller.dart';
import '../../utils/articles.dart';
import '../../utils/colors.dart';
import '../../utils/loading.dart';
import '../../utils/urls.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({super.key});

  @override
  State<MobileHome> createState() => MobileHomeState();
}

class MobileHomeState extends State<MobileHome> {
  final HomepageController homepageController = Get.put(HomepageController());

  final ArticleController articleController = Get.put(ArticleController());
  @override
  void initState() {
    articleController.initArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(
          () => homepageController.isLoading.value
              ? const Center(child: KLoading())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Header(),
                      const SizedBox(height: 20),
                      Banner(),
                      const SizedBox(height: 20),
                      const Cards(),
                      const SizedBox(height: 20),
                      const UploadPrescription(),
                      const SizedBox(height: 20),
                      NearbyLabs(),
                      const SizedBox(height: 20),
                      trendingArticle(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget trendingArticle() {
    return Column(
      children: [
        const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            'Trending',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 16,
            ),
          ),
          Text(
            'View All',
            style: TextStyle(
              color: kGreen,
              fontSize: 16,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ]),
        const SizedBox(height: 20),
        SizedBox(
          width: Get.width,
          height: 200,
          child: ListView.builder(
            itemCount: articleController.trandingPosts.length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return ArticleCard(
                post: articleController.trandingPosts[index],
              );
            },
          ),
        ),
      ],
    );
  }
}

class NearbyLabs extends StatelessWidget {
  NearbyLabs({
    super.key,
  });

  final HomepageController homepageController = Get.put(HomepageController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nearby Laboratories',
              style: TextStyle(
                color: kText,
                fontSize: 16,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            const Text(
              'View All',
              style: TextStyle(
                color: kGreen,
                fontSize: 16,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: homepageController.pathologies.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              Pathlogy pathlogy = homepageController.pathologies[index];
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  width: Get.width - 100,
                  height: 100,
                  decoration: ShapeDecoration(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        baseUrl + pathlogy.image,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class UploadPrescription extends StatelessWidget {
  const UploadPrescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: ShapeDecoration(
        color: kGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
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
          const Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upload Prescription',
                style: TextStyle(
                  color: kWhite,
                  fontSize: 16,
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
          )
        ],
      ),
    );
  }
}

class Cards extends StatelessWidget {
  const Cards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircularCardOffline(
              image: "assets/app_icons/lab-technician.png",
              text: "Book A Test",
              onTap: () {
                context.push("/book-a-test");
              },
            ),
            CircularCardOffline(
              image: "assets/app_icons/lady-doing-yoga.png",
              text: "Health Tips",
              onTap: () => {},
            ),
            CircularCardOffline(
              image: "assets/app_icons/x-rays.png",
              text: "X-ray Scan",
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class CircularCardOffline extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onTap;

  const CircularCardOffline({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              color: kGreenOpacity,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(image),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            text,
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
    );
  }
}

class CircularCard extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onTap;
  const CircularCard({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(baseUrl + image),
          ),
          const SizedBox(height: 10),
          Text(
            text,
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

class Header extends StatelessWidget {
  Header({
    super.key,
  });
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Column(
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
                                borderRadius: BorderRadius.circular(200),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              context.push("/notification");
                            },
                            child: const Icon(
                              CupertinoIcons.bell,
                              color: kGreen,
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              context.push("/cart");
                            },
                            child: const Icon(
                              CupertinoIcons.shopping_cart,
                              color: kGreen,
                            ),
                          ),
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
            context.push("/search");
          },
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: kWhite,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFFE8E8E8)),
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
    );
  }
}
