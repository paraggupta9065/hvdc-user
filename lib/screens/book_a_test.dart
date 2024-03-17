import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../utils/card.dart';
import '../utils/colors.dart';
import '../utils/style.dart';
import 'homepage.dart';
import 'notification.dart';

class BookATest extends StatefulWidget {
  const BookATest({super.key});

  @override
  State<BookATest> createState() => _BookATestState();
}

class _BookATestState extends State<BookATest> {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircularCard(
                    image: "",
                    text: "Book A Test",
                    onTap: () {},
                  ),
                  CircularCard(
                    image: "",
                    text: "Lab Test",
                    onTap: () => {},
                  ),
                  CircularCard(
                    image: "",
                    text: "X-ray Scan",
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircularCard(
                    image: "",
                    text: "Book A Test",
                    onTap: () {},
                  ),
                  CircularCard(
                    image: "",
                    text: "Lab Test",
                    onTap: () => {},
                  ),
                  CircularCard(
                    image: "",
                    text: "X-ray Scan",
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircularCard(
                    image: "",
                    text: "Book A Test",
                    onTap: () {},
                  ),
                  CircularCard(
                    image: "",
                    text: "Lab Test",
                    onTap: () => {},
                  ),
                  CircularCard(
                    image: "",
                    text: "X-ray Scan",
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircularCard(
                    image: "",
                    text: "Book A Test",
                    onTap: () {},
                  ),
                  CircularCard(
                    image: "",
                    text: "Lab Test",
                    onTap: () => {},
                  ),
                  CircularCard(
                    image: "",
                    text: "X-ray Scan",
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
