import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hvdc_user/controllers/date_controller.dart';
import 'package:hvdc_user/utils/colors.dart';
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
  final DateController dateController = Get.put(DateController());
  @override
  void initState() {
    super.initState();
    dateController.selectedDate.value = DateTime.now();
  }

  String title = "Book Appointment";
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
                Text(
                  'Select Date',
                  style: kTextStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
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
                      currentDay: dateController.selectedDate.value,
                      focusedDay: dateController.selectedDate.value,
                      firstDay: DateTime.utc(2000, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                      ),
                      onDaySelected: (date, focusedDay) {
                        print(dateController.selectedDate);
                        dateController.selectedDate.value = date;
                        dateController.selectedDate.value = focusedDay;
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
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    selectHour('09:30 AM', 0, dateController.isClickTime),
                    const SizedBox(
                      width: 10,
                    ),
                    selectHour('10:30 AM', 1, dateController.isClickTime),
                    const SizedBox(
                      width: 10,
                    ),
                    selectHour('11:00 PM', 2, dateController.isClickTime)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    selectHour('02:30 PM', 3, dateController.isClickTime),
                    const SizedBox(
                      width: 10,
                    ),
                    selectHour('07:30 AM', 4, dateController.isClickTime),
                    const SizedBox(
                      width: 10,
                    ),
                    selectHour('08:00 PM', 5, dateController.isClickTime)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    selectHour('01:30 PM', 6, dateController.isClickTime),
                    const SizedBox(
                      width: 10,
                    ),
                    selectHour('05:30 PM', 7, dateController.isClickTime),
                    const SizedBox(
                      width: 10,
                    ),
                    selectHour('09:00 AM', 8, dateController.isClickTime)
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kButtonGreen,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 120, vertical: 20), // Button padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Button border radius
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Book Appointment",
                      style: kTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: kWhite),
                    ))
              ]),
        ),
      ),
    );
  }

  GestureDetector selectHour(String time, int index, RxList<bool> isClicked) {
    return GestureDetector(
      onTap: () {
        isClicked[index] = !isClicked[index];
      },
      child: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: isClicked[index] ? kNavy : kGreen.withOpacity(0.1),
            border: Border.all(
                color: isClicked[index]
                    ? Colors.transparent
                    : kGreen.withOpacity(0.6)),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            time,
            style: kTextStyle.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: isClicked[index] ? kWhite : kGreen.withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }
}
