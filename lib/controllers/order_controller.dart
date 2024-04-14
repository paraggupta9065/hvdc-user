import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/controllers/address_controller.dart';
import 'package:hvdc_user/controllers/cart_controller.dart';
import 'package:hvdc_user/controllers/patient_controller.dart';
import 'package:hvdc_user/models/orders.dart';
import 'package:hvdc_user/utils/routing.dart';
import 'package:lottie/lottie.dart';

import '../utils/request_handler.dart';
import '../utils/toast.dart';
import 'auth_controller.dart';

class OrderController extends GetxController {
  RxBool isLoadingOrders = RxBool(false);
  AddressController addressController = Get.put(AddressController());
  PatientController patientController = Get.put(PatientController());
  CartController cartController = Get.put(CartController());
  List<Order> orders = [];

  Future createOrder() async {
    try {
      isLoadingOrders.value = true;
      String endpoint = "/orders/";

      String? token = getToken();
      DateTime dateTime = cartController.selectedDate.value;

      Map body = {
        "patient": patientController.selectedPatient.value == 0
            ? ""
            : patientController.selectedPatient.value,
        "address": addressController.selectedAddress.value == 0
            ? ""
            : addressController.selectedAddress.value,
        "day": dateTime.day,
        "month": dateTime.month,
        "year": dateTime.year,
        "hour": cartController.selectedSlot.value,
        "minute": 00
      };
      dynamic response = await ApiHelper.post(
        endpoint,
        body,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      await getOrders();
      Get.dialog(
        Lottie.asset(
          'assets/animation/sucess.json',
          onLoaded: (p0) {
            Future.delayed(const Duration(seconds: 2)).then((value) {
              while (true) {
                print(router.routerDelegate.currentConfiguration.matches.last
                    .matchedLocation);
                if (router.routerDelegate.currentConfiguration.matches.last
                        .matchedLocation !=
                    "/home") {
                  Get.back();
                  if (router.canPop()) {
                    router.pop();
                  }
                } else {
                  break;
                }
              }
            });
          },
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString(), duration: 2);
    } finally {
      isLoadingOrders.value = false;
    }
  }

  Future getOrders() async {
    try {
      isLoadingOrders.value = true;

      String endpoint = "/orders/";

      String? token = getToken();

      dynamic response = await ApiHelper.get(
        endpoint,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      dynamic rawOrders = response['results'];
      orders = List.generate(
          rawOrders.length, (index) => Order.fromJson(rawOrders[index]));
    } finally {
      isLoadingOrders.value = false;
    }
  }
}
