import 'dart:convert';
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
      orders = List.generate(
          rawOrders.length, (index) => Order.fromJson(rawOrders[index]));
    } finally {
      isLoadingOrders.value = false;
    }
  }

  download({required String url}) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();

    var storage = statuses[Permission.storage];
    var manageExternalStorage = statuses[Permission.manageExternalStorage];

    if (storage!.isDenied || manageExternalStorage!.isDenied) {
      kShowSnackbar(title: "", message: "Please grant permission!");
    } else {
      final response = await Dio().get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      Directory? directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        directory = await getExternalStorageDirectory();
      }
      File file = File(directory?.path ?? '/');
      await file.writeAsBytes(response.data);
      print('File downloaded to: $file');
      print(file);
    }
  }
}
