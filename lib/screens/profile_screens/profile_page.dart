import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hvdc_user/utils/appBar.dart';
import 'package:hvdc_user/utils/colors.dart';
import 'package:hvdc_user/utils/img_name.dart';
import 'package:hvdc_user/utils/style.dart';

import '../../controllers/auth_controller.dart';
import '../../utils/loading.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar("Profile"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Obx(
                () => authController.isLoadingProfile.value
                    ? const Center(
                        child: KLoading(),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20.0)),
                              child: Image(
                                image: NetworkImage(
                                  authController.user?.profilePic ??
                                      "https://www.belizeplanners.org/wp-content/uploads/2016/01/male-placeholder.jpg",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                authController.user?.name ?? "",
                                style: kTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                authController.user?.email ?? "",
                                style: kTextStyle.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              profileItemList("Notification", notification, () {
                context.push("/notification");
              }),
              profileItemList("My Test Bookings", testBook, () {
                context.push('/bookings');
              }),
              profileItemList("Order History", orderHistory, () {}),
              profileItemList("Help Center", helpCenter, () {}),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Button border radius
            ),
          ),
          onPressed: () {},
          child: SizedBox(
            width: double.maxFinite,
            height: 60,
            child: Center(
              child: Text(
                "Logout",
                style: kTextStyle.copyWith(color: kWhite),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ListTile profileItemList(
      String title, String imageString, void Function() onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4),
      leading: Image(image: AssetImage(imageString)),
      title: Text(
        title,
        style: kTextStyle.copyWith(
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: onTap,
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
