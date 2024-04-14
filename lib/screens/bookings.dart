import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/utils/loading.dart';

import '../controllers/order_controller.dart';
import '../models/orders.dart';
import '../utils/appBar.dart';
import '../utils/card.dart';
import '../utils/colors.dart';
import '../utils/style.dart';

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
          appBar: KAppBar("Bookings"),
          body: Obx(
            () => orderController.isLoadingOrders.value
                ? const KLoading()
                : listView(),
          )),
    );
  }

  ListView listView() {
    return ListView.builder(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.patient.name,
                    style: kTextStyle.copyWith(
                        fontSize: 18,
                        color: kText,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    order.address.street,
                    style: kTextStyle.copyWith(
                        fontSize: 14,
                        color: kText,
                        fontWeight: FontWeight.w400),
                  ),
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
                ],
              ),
            ],
          )),
      height: 100,
      width: double.infinity,
    );
  }
}
