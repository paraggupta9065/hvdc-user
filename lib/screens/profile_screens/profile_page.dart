import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hvdc_user/utils/appBar.dart';
import 'package:hvdc_user/utils/colors.dart';
import 'package:hvdc_user/utils/img_name.dart';
import 'package:hvdc_user/utils/style.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/auth_controller.dart';
import '../../utils/loading.dart';
import '../../utils/routing.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    bool isLogin = authController.isLogin();
    if (!isLogin) {
      authController.logout();
    }

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
                                      "https://devapi.hvdc.in/static/profile-placeholder.png",
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
                                authController.user?.name ?? "User",
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
                Get.toNamed("/notification");
              }),
              profileItemList("My Test Bookings", testBook, () {
                Get.toNamed('/bookings');
              }),
              profileItemList("Help Center", helpCenter, () {
                launchUrl(Uri.parse(
                    "https://web.whatsapp.com/send?phone=917065376565&text=Hello"));
              }),
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
          onPressed: () {
            authController.logout();
          },
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
