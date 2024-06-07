import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faq/flutter_faq.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:hive/hive.dart';
import 'package:hvdc_user/controllers/cart_controller.dart';
import 'package:hvdc_user/models/packages.dart';
import 'package:hvdc_user/models/pathlogy.dart';
import 'package:hvdc_user/models/test.dart';
import 'package:hvdc_user/screens/home/web_home.dart';
import 'package:hvdc_user/utils/card.dart';
import 'package:hvdc_user/utils/responsive.dart';
import 'package:hvdc_user/utils/routing.dart';
import 'package:shimmer/shimmer.dart';

import '../../controllers/article_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/homepage_controller.dart';
import '../../controllers/packages_controller.dart';
import '../../utils/articles.dart';
import '../../utils/colors.dart';
import '../../utils/loading.dart';
import '../../utils/style.dart';
import '../../utils/urls.dart';
import 'header.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({super.key});

  @override
  State<MobileHome> createState() => MobileHomeState();
}

class MobileHomeState extends State<MobileHome> {
  final HomepageController homepageController = Get.put(HomepageController());
  final CartController cartController = Get.put(CartController());
  final ArticleController articleController = Get.put(ArticleController());
  final PackagesController packagesController = Get.put(PackagesController());
  @override
  void initState() {
    articleController.initArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String data = "";
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => homepageController.authController.isLoadingProfile.value
                    ? SizedBox(
                        width: kWidth(100) - 20,
                        height: 125.0,
                        child: Shimmer.fromColors(
                          baseColor: kGrey.withOpacity(0.1),
                          highlightColor: kWhite,
                          child: kContainer(
                            color: kText,
                            child: const SizedBox(),
                          ),
                        ),
                      )
                    : Header(),
              ),
              const SizedBox(height: 20),
              Banner(),
              const SizedBox(height: 20),
              const Cards(),
              const SizedBox(height: 20),
              const UploadPrescription(),
              const SizedBox(height: 20),
              NearbyLabs(),
              const SizedBox(height: 20),
              packages(),
              const SizedBox(height: 20),
              trendingArticle(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
      floatingActionButton:
          BottomCartWidth(isLoading: homepageController.isLoading),
    );
  }

  Column packages() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Packages',
          style: kTextStyle,
        ),
        const SizedBox(height: 20),
        Obx(
          () => packagesController.isLoadingPackages.value
              ? SizedBox(
                  width: kWidth(100) - 20,
                  height: 200.0,
                  child: Shimmer.fromColors(
                    baseColor: kGrey.withOpacity(0.1),
                    highlightColor: kWhite,
                    child: kContainer(
                      color: kText,
                      child: const SizedBox(),
                    ),
                  ),
                )
              : CarouselSlider.builder(
                  options: CarouselOptions(
                    aspectRatio: 20 / 6.5,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 1000),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                  itemCount: packagesController.packages.length,
                  itemBuilder:
                      (BuildContext context, int index, int pageViewIndex) {
                    Packages packages = packagesController.packages[index];
                    return InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => kContainer(
                            child: SizedBox(
                              width: kWidth(100),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      packages.name,
                                      style: kTextStyle.copyWith(),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      packages.description,
                                      maxLines: 3,
                                      style: kTextStyle.copyWith(
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    GridView.builder(
                                      itemCount: packages.tests.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 7.0,
                                              mainAxisExtent: 20),
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        PackageTest test =
                                            packages.tests[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2),
                                          child: Text(
                                            test.name,
                                            style: kTextStyle.copyWith(
                                              fontSize: 12,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "₹ ${packages.regularPrice}",
                                      style: kTextStyle.copyWith(
                                        fontSize: 12,
                                        color: kGrey.withOpacity(0.7),
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: kGrey.withOpacity(0.7),
                                      ),
                                    ),
                                    Text(
                                      "₹ ${packages.price}",
                                      style: kTextStyle.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Expanded(child: SizedBox()),
                                    Obx(
                                      () => cartController.isLoadingCart.value
                                          ? const KLoadingCircular()
                                          : TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        kGreen),
                                                shape: MaterialStateProperty.all(
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12)))),
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
                                                    style: kTextStyle.copyWith(
                                                        color: kWhite),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: kContainer(
                        child: SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  packages.name,
                                  style: kTextStyle,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  packages.description,
                                  maxLines: 3,
                                  style: kTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "₹ ${packages.price}",
                                  style: kTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
        ),
      ],
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
            '',
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
        Obx(
          () => articleController.isLoading.value
              ? SizedBox(
                  width: kWidth(100) - 20,
                  height: 125.0,
                  child: Shimmer.fromColors(
                    baseColor: kGrey.withOpacity(0.1),
                    highlightColor: kWhite,
                    child: kContainer(
                      color: kText,
                      child: const SizedBox(),
                    ),
                  ),
                )
              : SizedBox(
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
                          post: articleController.trandingPosts[index],
                        ),
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}

class BottomCartWidth extends StatelessWidget {
  BottomCartWidth({
    super.key,
    required this.isLoading,
  });

  final CartController cartController = Get.put(CartController());
  final RxBool isLoading;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => cartController.isLoadingCart.value || isLoading.value
          ? const SizedBox()
          : (cartController.cart?.cart.tests ?? []).isEmpty
              ? const SizedBox()
              : InkWell(
                  onTap: () {
                    Get.toNamed("/cart");
                  },
                  child: Container(
                    height: 50,
                    width: kWidth(91),
                    decoration: ShapeDecoration(
                      color: kGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: kWidth(3)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${(((cartController.cart?.cart.tests ?? []).length) + ((cartController.cart?.cart.packages ?? []).length))} Tests Added",
                              style: kTextStyle.copyWith(
                                  fontSize: 12,
                                  color: kWhite,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '₹ ${cartController.cart?.cartTotal ?? 0}',
                              style: kTextStyle.copyWith(
                                  fontSize: 16,
                                  color: kWhite,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                        Text(
                          'Book Now',
                          style: kTextStyle.copyWith(
                              fontSize: 16,
                              color: kWhite,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(width: kWidth(3)),
                      ],
                    ),
                  ),
                ),
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
              style: kTextStyle,
            ),
            const Text(
              "",
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
        Obx(
          () => homepageController.isLoadingPathlogy.value
              ? SizedBox(
                  width: kWidth(100) - 20,
                  height: 200.0,
                  child: Shimmer.fromColors(
                    baseColor: kGrey.withOpacity(0.1),
                    highlightColor: kWhite,
                    child: kContainer(
                      color: kText,
                      child: const SizedBox(),
                    ),
                  ),
                )
              : SizedBox(
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            color: kGreen,
                            image: DecorationImage(
                              image: NetworkImage(
                                baseUrl + pathlogy.image,
                              ),
                              fit: BoxFit.cover,
                              opacity: 0.5,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pathlogy.name,
                                      style: kTextStyle.copyWith(
                                          fontSize: 20,
                                          color: kWhite,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: kHeight(1)),
                                    Text(
                                      pathlogy.address,
                                      style: kTextStyle.copyWith(
                                          fontSize: 12,
                                          color: kWhite,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      );
                    },
                  ),
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
    return InkWell(
      onTap: () {
        Get.toNamed('/upload_prescription');
      },
      child: Container(
        height: kIsWeb ? 150 : 100,
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
                Get.toNamed("/book-a-test");
              },
            ),
            CircularCardOffline(
              image: "assets/app_icons/lady-doing-yoga.png",
              text: "Health Tips",
              onTap: () {
                Get.toNamed("/articles");
              },
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
    return Obx(
      () => homepageController.isLoadingBanner.value ||
              homepageController.banners.isEmpty
          ? SizedBox(
              width: kWidth(100) - 20,
              height: 170.0,
              child: Shimmer.fromColors(
                baseColor: kGrey.withOpacity(0.1),
                highlightColor: kWhite,
                child: kContainer(
                  color: kText,
                  child: const SizedBox(),
                ),
              ),
            )
          : CarouselSlider.builder(
              options: CarouselOptions(
                aspectRatio: 16 / 8,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
              itemCount: homepageController.banners.length,
              itemBuilder:
                  (BuildContext context, int index, int pageViewIndex) =>
                      ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: Image.network(
                    baseUrl + homepageController.banners[index].image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
    );
  }
}
