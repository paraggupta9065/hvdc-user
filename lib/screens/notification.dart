import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hvdc_user/utils/appBar.dart';
import 'package:hvdc_user/utils/colors.dart';

import '../utils/style.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar("Notification"),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return const NotificationTile(
              icon: '',
              title: "Appointment Cancelled",
              description:
                  "You have successfully cancelled your appointment with Dr. Alan Watson on December 24, 2024. 13:00 pm. 80% of the funds will be returned to your account.",
              date: "Today | 15:36 PM",
            );
          },
        ),
      )),
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
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: kGreenOpacity,
              radius: 30,
              child: Icon(
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
