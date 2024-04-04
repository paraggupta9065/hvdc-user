import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:hvdc_user/models/test.dart';
import 'package:hvdc_user/utils/request_handler.dart';

import '../utils/toast.dart';
import 'auth_controller.dart';

class TestsController extends GetxController {
  List<Test> tests = [];
  RxBool isLoadingTests = RxBool(false);
  RxInt openIndex = RxInt(0);

  Future getTests({required String categoryId}) async {
    try {
      isLoadingTests.value = true;
      String endpoint = "/pathology_test/?category=$categoryId";

      String? token = getToken();

      dynamic response = await ApiHelper.get(
        endpoint,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      List rawTests = response['results'];

      tests = List<Test>.generate(
          rawTests.length, (index) => Test.fromJson(rawTests[index]));
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString());
    } finally {
      isLoadingTests.value = false;
    }
  }
}
