import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:hvdc_user/models/packages.dart';
import 'package:hvdc_user/models/test.dart';
import 'package:hvdc_user/utils/request_handler.dart';

import '../utils/toast.dart';
import 'auth_controller.dart';

class PackagesController extends GetxController {
  List<Packages> packages = [];
  RxBool isLoadingPackages = RxBool(false);
  RxInt openIndex = RxInt(0);

  Future getPackages() async {
    try {
      isLoadingPackages.value = true;
      String endpoint = "/packages/";

      String? token = getToken();

      dynamic response = await ApiHelper.get(
        endpoint,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      List rawPackages = response['results'];

      packages = List<Packages>.generate(
          rawPackages.length, (index) => Packages.fromJson(rawPackages[index]));
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString());
    } finally {
      isLoadingPackages.value = false;
    }
  }
}
