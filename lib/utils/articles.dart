import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/utils/colors.dart';
import 'package:hvdc_user/utils/style.dart';

class Articles extends StatelessWidget {
  const Articles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Articles',
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'See All',
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  width: Get.width,
                  height: 50,
                  child: ListView.builder(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kGreen,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFFFFFFFF),
                        ),
                        margin: const EdgeInsets.only(right: 16),
                        width: 91,
                        child: const Center(
                          child: Text(
                            'Health',
                            style: TextStyle(
                              color: Color(0xFF4A7C4C),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (BuildContext context, int index) {
                  return const ArticleTile();
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
                        'See All',
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
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return const ArticleCard();
                    },
                  ),
                ),
              ),
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
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 130,
            width: 220,
            decoration: BoxDecoration(
                color: kGreen, borderRadius: BorderRadius.circular(16)),
          ),
          const SizedBox(height: 10),
          Text(
            'COVID-19 Was a Top Cause\nof Death in 2020 and 2021,\nEven For Younger People',
            style: kTextStyle.copyWith(fontSize: 16),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class ArticleTile extends StatelessWidget {
  const ArticleTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Container(
            height: 110,
            width: 110,
            decoration: BoxDecoration(
                color: kGreen, borderRadius: BorderRadius.circular(16)),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Dec 22,2022',
                  style: kTextStyle.copyWith(fontSize: 12),
                ),
                Text(
                  'COVID-19 Was a Top Cause\nof Death in 2020 and 2021,\nEven For Younger People',
                  style: kTextStyle.copyWith(fontSize: 16),
                ),
                Text(
                  'Covid-19',
                  style: kTextStyle.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
