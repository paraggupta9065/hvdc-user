import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/screens/home/header.dart';
import 'package:hvdc_user/utils/loading.dart';
import 'package:hvdc_user/utils/padding.dart';
import 'package:hvdc_user/utils/responsive.dart';

import '../controllers/order_controller.dart';
import '../models/orders.dart';
import '../utils/appBar.dart';
import '../utils/card.dart';
import '../utils/colors.dart';
import '../utils/style.dart';
import 'home/footer.dart';
import 'home/web_home.dart';

class Bookings extends StatefulWidget {
  const Bookings({super.key});

  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: kWeb ? null : KAppBar("Bookings"),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (kWeb) Header(),
                const SizedBox(height: 20),
                Obx(
                  () => orderController.isLoadingOrders.value
                      ? const KLoading()
                      : kWeb
                          ? gridView()
                          : listView(),
                ),
                const SizedBox(height: 20),
                Footer(),
              ],
            ),
          )),
    );
  }

  ListView listView() {
    return ListView.builder(
      padding: kWeb ? kWebPadding : const EdgeInsets.symmetric(horizontal: 20),
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: orderController.orders.length,
      itemBuilder: (BuildContext context, int index) {
        Order order = orderController.orders[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: orderTile(order),
        );
      },
    );
  }

  Widget gridView() {
    return GridView.builder(
      padding: kWeb ? kWebPadding : const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 20,
          childAspectRatio: 2.5),
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: orderController.orders.length,
      itemBuilder: (BuildContext context, int index) {
        Order order = orderController.orders[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: orderTile(order),
        );
      },
    );
  }

  Container orderTile(Order order) {
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: kWeb ? kWidth(22.5) : kWidth(78),
                    child: Text(
                      order.status == 'pending'
                          ? "${order.patient.name}'s booking has been successfully reserved"
                          : order.status == 'processing'
                              ? "Your sample pickup is currently in progress"
                              : order.status == 'completed'
                                  ? "Your sample has been successfully collected."
                                  : order.status == 'uploaded'
                                      ? "Your report has been successfully uploaded."
                                      : "Your test has been canceled.",
                      style: kTextStyle.copyWith(
                          fontSize: 18,
                          color: kText,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    order.address.street,
                    style: kTextStyle.copyWith(
                        fontSize: 14,
                        color: kText,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "₹ ${order.total_price}",
                        style: kTextStyle.copyWith(
                            fontSize: 16,
                            color: kGreen,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (order.status == 'uploaded')
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kGreen),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)))),
                      ),
                      onPressed: () {
                        orderController.download(url: order.report);
                      },
                      child: SizedBox(
                        height: 30,
                        width: kWeb ? kWidth(22.65) : kWidth(73),
                        child: const Center(
                          child: Text(
                            "Download",
                            style: TextStyle(
                              color: kWhite,
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ],
          )),
      height: order.status == 'uploaded' ? 180 : 130,
      width: double.infinity,
    );
  }
}
