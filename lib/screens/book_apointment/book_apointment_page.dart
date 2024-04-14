import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hvdc_user/controllers/cart_controller.dart';
import 'package:hvdc_user/controllers/order_controller.dart';
import 'package:hvdc_user/utils/colors.dart';
import 'package:hvdc_user/utils/loading.dart';
import 'package:hvdc_user/utils/responsive.dart';
import 'package:hvdc_user/utils/style.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utils/appBar.dart';

class AppointmentBookingScreen extends StatefulWidget {
  const AppointmentBookingScreen({super.key});

  @override
  State<AppointmentBookingScreen> createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  final CartController cartController = Get.put(CartController());
  final OrderController orderController = Get.put(OrderController());
  @override
  void initState() {
    super.initState();
    cartController.selectedDate.value = DateTime.now();
  }

  String title = "Select Date";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(title),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: HexColor('#4CAF50').withOpacity(0.1),
                    ),
                    child: TableCalendar(
                      calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: kNavy,
                          shape: BoxShape.circle,
                        ),
                      ),
                      currentDay: cartController.selectedDate.value,
                      focusedDay: cartController.selectedDate.value,
                      firstDay: DateTime.utc(2000, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                      ),
                      onDaySelected: (date, focusedDay) {
                        print(cartController.selectedDate);
                        cartController.selectedDate.value = date;
                        cartController.selectedDate.value = focusedDay;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Select Hour',
                  style: kTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: cartController.slots.length,
                  itemBuilder: (BuildContext context, int index) {
                    int slot = cartController.slots[index];
                    return selectHour(
                        slot < 13 ? '$slot:00 AM' : '${slot - 12}:00 PM', slot);
                  },
                ),
                const SizedBox(height: 20),
                Obx(
                  () => cartController.isLoadingCart.value ||
                          cartController.isEmpty.value
                      ? const SizedBox()
                      : TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(kGreen),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)))),
                          ),
                          onPressed: () {
                            orderController.createOrder();
                          },
                          child: SizedBox(
                            height: 40,
                            width: double.maxFinite,
                            child: Center(
                              child: orderController.isLoadingOrders.value
                                  ? const KLoadingCircular()
                                  : const Text(
                                      "Complete",
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
              ]),
        ),
      ),
    );
  }

  Widget selectHour(String time, int slot) {
    return SizedBox(
      child: GestureDetector(
        onTap: () {
          cartController.selectedSlot.value = slot;
        },
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
              color: cartController.selectedSlot.value == slot
                  ? kNavy
                  : kGreenOpacity,
              border: Border.all(
                  color: cartController.selectedSlot.value == slot
                      ? Colors.transparent
                      : kGreenOpacityDark),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                time,
                style: kTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: cartController.selectedSlot.value == slot
                      ? kWhite
                      : kGreenOpacityDark,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
