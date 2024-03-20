import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:hvdc_user/utils/colors.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: const Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Header(),
                SizedBox(height: 20),
                Banner(),
                SizedBox(height: 20),
                Cards(),
                SizedBox(height: 20),
                UploadPrescription(),
                SizedBox(height: 20),
                NearbyLabs()
              ],
            ),
          ),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   selectedItemColor: kGreen,
        //   unselectedItemColor: kGrey,
        //   onTap: (value) {
        //     print(value);
        //   },
        //   items: const [
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         CupertinoIcons.house,
        //       ),
        //       label: "Home",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         CupertinoIcons.calendar,
        //       ),
        //       label: "Booking",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         CupertinoIcons.doc_plaintext,
        //       ),
        //       label: "Articles",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         CupertinoIcons.person,
        //       ),
        //       label: "Profile",
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

class NearbyLabs extends StatelessWidget {
  const NearbyLabs({
    super.key,
  });

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
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
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
            child: Icon(
              FontAwesomeIcons.image,
              color: kWhite,
            ),
          ),
          Column(
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
              const SizedBox(height: 8),
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
            child: Center(
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
            CircularCard(
              image: "",
              text: "Book A Test",
              onTap: () {
                context.push("/book-a-test");
              },
            ),
            CircularCard(
              image: "",
              text: "Health Tips",
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
      ],
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
          const CircleAvatar(
            radius: 35,
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
  const Banner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            itemCount: 3,
            itemBuilder: (context, index) => Container(
              width: double.infinity,
              height: 180,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Image.asset("assets/banner.png"),
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
  const Header({
    super.key,
  });

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
                              image: const DecorationImage(
                                image: NetworkImage(
                                    "https://via.placeholder.com/48x48"),
                                fit: BoxFit.fill,
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
                              const Text(
                                'Hello Sharma',
                                style: TextStyle(
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
                            child: Icon(
                              CupertinoIcons.bell,
                              color: kGreen,
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              context.push("/cart");
                            },
                            child: Icon(
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
