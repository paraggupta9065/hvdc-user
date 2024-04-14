import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/utils/toast.dart';

import '../models/address.dart';
import '../utils/request_handler.dart';
import 'auth_controller.dart';

class AddressController {
  RxBool isLoadingAddress = RxBool(false);

  TextEditingController street = TextEditingController();
  TextEditingController city = TextEditingController(text: "delhi");
  TextEditingController state = TextEditingController(text: "delhi");
  TextEditingController pincode = TextEditingController();

  RxInt selectedAddress = RxInt(0);

  Future addAddressCart() async {
    try {
      isLoadingAddress.value = true;
      String endpoint = "/user/address/";

      String? token = getToken();

      dynamic response = await ApiHelper.post(
        endpoint,
        {
          "street": street.text,
          "city": city.text,
          "state": state.text,
          "postal_code": pincode.text,
        },
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      await getAddressCart();
      Get.back();
      kShowSnackbar(title: "Sucess !", message: response['detail'].toString());
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString(), duration: 2);
    } finally {
      isLoadingAddress.value = false;
    }
  }

  List<Address> address = [];
  Future getAddressCart() async {
    try {
      isLoadingAddress.value = true;
      String endpoint = "/user/address/";

      String? token = getToken();

      dynamic response = await ApiHelper.get(
        endpoint,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      List rawAddress = response['results'];
      address = List.generate(
          rawAddress.length, (index) => Address.fromJson(rawAddress[index]));
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString(), duration: 2);
    } finally {
      isLoadingAddress.value = false;
    }
  }
}
