import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hvdc_user/utils/colors.dart';
import 'package:hvdc_user/utils/img_name.dart';
import 'package:hvdc_user/utils/style.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.more_vert,
              size: 30,
            ),
          )
        ],
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: kTextStyle.copyWith(
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      child: Image(
                        image: NetworkImage(
                          'https://media.them.us/photos/5ca391a6b9aba0ee4c0bc2d6/1:1/w_1279,h_1279,c_limit/RUSSELL.jpg',
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
                        "Yuri Sharma",
                        style: kTextStyle.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "yurisharma@gmail.com",
                        style: kTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              profileItemList("Edit Profile", person, () {}),
              profileItemList("Notification", notification, () {}),
              profileItemList("My Cards", cardIcon, () {}),
              profileItemList("My Home Visits", homeVisit, () {}),
              profileItemList("My Test Bookings", testBook, () {
                context.push('/profile/test-booking');
              }),
              profileItemList("Order History", orderHistory, () {}),
              profileItemList("Help Center", helpCenter, () {}),
              const SizedBox(height: 40),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kButtonGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Button border radius
                    ),
                  ),
                  onPressed: () {},
                  child: SizedBox(
                    width: double.maxFinite,
                    height: 60,
                    child: Center(
                      child: Text(
                        "Logout",
                        style: kTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            color: kWhite),
                      ),
                    ),
                  ))
            ],
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
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: onTap,
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
