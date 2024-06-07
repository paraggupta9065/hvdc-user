import 'dart:convert';
import 'dart:html' as html;
import 'dart:html';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/controllers/address_controller.dart';
import 'package:hvdc_user/controllers/cart_controller.dart';
import 'package:hvdc_user/controllers/patient_controller.dart';
import 'package:hvdc_user/models/orders.dart';
import 'package:hvdc_user/utils/routing.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

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
      loadingOverlay();

      dynamic response = await ApiHelper.post(
        endpoint,
        body,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      await getOrders();

      Get.back();
      Get.dialog(
        Lottie.asset(
          'assets/animation/sucess.json',
          onLoaded: (p0) {
            Future.delayed(const Duration(seconds: 2)).then((value) {
              Get.offAllNamed("/home");
              // while (true) {
              //   // if (Getn.routerDelegate.currentConfiguration.matches.last
              //   //         .route !=
              //   //     "/home") {
              //   //   Get.back();
              //   //   if (Get.) {
              //   //     Get.back();
              //   //   }
              //   // } else {
              //   //   break;
              //   // }
              // }
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

  loadingOverlay() {
    Get.dialog(
      SizedBox(
        width: 200,
        height: 200,
        child: Lottie.asset(
          'assets/animation/loading-circle.json',
        ),
      ),
      barrierDismissible: false,
    );
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

      orders = List.generate(rawOrders.length, (index) {
        Order order = Order.fromJson(rawOrders[index]);
        return order;
      });
    } finally {
      isLoadingOrders.value = false;
    }
  }

  downloadWeb({required String url}) async {
    try {
      if (!(url.contains("https"))) {
        url = url.replaceAll("http", "https");
      }

      print("dlonload done");
      print("url");
      List splitList = url.split(".");
      String name =
          ("${DateTime.timestamp()}." + (splitList[splitList.length - 1]));
      await FileSaver.instance.saveFile(
        name: name,
        link: LinkDetails(
          link: url,
          method: "GET",
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
