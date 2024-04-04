import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hvdc_user/controllers/homepage_controller.dart';
import '../models/category.dart';
import '../utils/colors.dart';
import '../utils/style.dart';
import 'home/homepage.dart';
import 'home/mobile_home.dart';

class BookATest extends StatefulWidget {
  const BookATest({super.key});

  @override
  State<BookATest> createState() => _BookATestState();
}

class _BookATestState extends State<BookATest> {
  HomepageController homepageController = Get.put(HomepageController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        child: const Icon(
                          Icons.arrow_back,
                          size: 25,
                        ),
                        onTap: () {
                          context.pop();
                        },
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Book a Test",
                        style: kTextStyle.copyWith(
                            fontSize: 16,
                            color: kText,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  InkWell(
                    child: const Icon(
                      CupertinoIcons.search,
                      size: 25,
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              FutureBuilder(
                future: homepageController.getCategories(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  List<Category> categories = homepageController.categories;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      Category category = categories[index];
                      return CircularCard(
                        image: category.image,
                        text: category.categoryName,
                        onTap: () {
                          context.push(
                              "/tests?category_id=${category.id}&category_name=${category.categoryName}");
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
