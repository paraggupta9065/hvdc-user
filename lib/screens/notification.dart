import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/controllers/homepage_controller.dart';
import 'package:hvdc_user/models/notiification.dart';
import 'package:hvdc_user/utils/appBar.dart';
import 'package:hvdc_user/utils/colors.dart';
import 'package:hvdc_user/utils/loading.dart';

import '../utils/style.dart';

class Notifications extends StatelessWidget {
  Notifications({super.key});

  final HomepageController homepageController = Get.put(HomepageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar("Notification"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Obx(
            () => homepageController.isLoadingNotifications.value
                ? const KLoading()
                : ListView.builder(
                    itemCount: homepageController.notifications.length,
                    itemBuilder: (BuildContext context, int index) {
                      UserNotification userNotification =
                          homepageController.notifications[index];

                      return NotificationTile(
                        icon: '',
                        title: userNotification.title,
                        description: userNotification.description,
                        date: "", //"Today | 15:36 PM",
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final String date;

  const NotificationTile({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: kGreenOpacity,
              radius: 30,
              child: const Icon(
                FontAwesomeIcons.check,
                color: kGreen,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: kTextStyle.copyWith(
                      fontSize: 16, color: kText, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 5),
                Text(
                  date,
                  style: kTextStyle.copyWith(
                      fontSize: 16, color: kGrey, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: kTextStyle.copyWith(
              fontSize: 14, color: kGrey, fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
