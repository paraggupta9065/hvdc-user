import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../utils/card.dart';
import '../utils/colors.dart';
import '../utils/style.dart';
import 'notification.dart';
import 'dart:math' as math;

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
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
                children: [
                  InkWell(
                    child: const Icon(
                      Icons.arrow_back,
                    ),
                    onTap: () {
                      context.pop();
                    },
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "Cart",
                    style: kTextStyle.copyWith(
                        fontSize: 16,
                        color: kText,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFF1F1F1),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(200),
                          color: kGreen.withOpacity(0.2),
                        ),
                        height: 45,
                        width: 45,
                        child: Icon(
                          FontAwesomeIcons.basketShopping,
                          color: kGreen,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "4 Items in Total",
                        style: kTextStyle.copyWith(
                            fontSize: 16,
                            color: kText,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Text(
                    "₹ 15.98",
                    style: kTextStyle.copyWith(
                        fontSize: 16,
                        color: kGreen,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              cartTile(),
              const SizedBox(height: 10),
              cartTile(),
              const SizedBox(height: 10),
              cartTile(),
              const SizedBox(height: 10),
              cartTile(),
              const SizedBox(height: 10),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(kGreen),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)))),
            ),
            onPressed: () => {},
            child: SizedBox(
              height: 40,
              width: double.maxFinite,
              child: Center(
                child: Text(
                  "Place Order",
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container cartTile() {
    return kContainer(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Vitamin C Chewable Tablet",
                    style: kTextStyle.copyWith(
                        fontSize: 16,
                        color: kText,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "Essentials",
                    style: kTextStyle.copyWith(
                        fontSize: 14,
                        color: kText,
                        fontWeight: FontWeight.w400),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "₹ 15.98",
                        style: kTextStyle.copyWith(
                            fontSize: 16,
                            color: kGreen,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "₹ 32.73",
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
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      CupertinoIcons.delete,
                      size: 17,
                    ),
                  ),
                  InkWell(
                      onTap: () {},
                      child: Transform.rotate(
                        angle: -math.pi / 2,
                        child: const Icon(
                          Icons.arrow_back_ios_sharp,
                          size: 17,
                        ),
                      )),
                ],
              )
            ],
          )),
      height: 100,
      width: double.infinity,
    );
  }
}
