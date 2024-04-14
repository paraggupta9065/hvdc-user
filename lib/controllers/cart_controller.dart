import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/models/address.dart';
import 'package:hvdc_user/models/test.dart';
import 'package:hvdc_user/screens/cart.dart';

import '../models/cart.dart';
import '../utils/request_handler.dart';
import '../utils/toast.dart';
import 'auth_controller.dart';

class CartController extends GetxController {
  RxBool isLoadingCart = RxBool(false);
  RxBool isEmpty = RxBool(false);
  CartModel? cart;
  final selectedDate = Rx<DateTime>(DateTime.now());
  final List slots = [9, 11, 12, 13, 14, 15, 16, 17];
  RxInt selectedSlot = RxInt(9);

  Future getCart() async {
    try {
      isLoadingCart.value = true;
      isEmpty.value = false;

      String endpoint = "/cart/";

      String? token = getToken();

      dynamic response = await ApiHelper.get(
        endpoint,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      dynamic rawCartItems = response['results'];
      cart = CartModel.fromJson(rawCartItems);
    } catch (e) {
      if (e.toString() == "not_found") {
        isEmpty.value = true;
      } else {
        kShowSnackbar(title: "Error !", message: e.toString());
      }
    } finally {
      isLoadingCart.value = false;
    }
  }

  Future addToCart(int test) async {
    try {
      isLoadingCart.value = true;
      String endpoint = "/cart/";

      String? token = getToken();

      dynamic response = await ApiHelper.post(
        endpoint,
        {"test": test},
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      await getCart();

      kShowSnackbar(title: "Sucess !", message: response['detail'].toString());
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString(), duration: 2);
    } finally {
      isLoadingCart.value = false;
    }
  }

  Future removeFromCart(int test) async {
    try {
      isLoadingCart.value = true;
      String endpoint = "/cart/remove/";

      String? token = getToken();

      dynamic response = await ApiHelper.post(
        endpoint,
        {"test": test.toString()},
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      kShowSnackbar(title: "Sucess !", message: response['detail'].toString());

      getCart();
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString(), duration: 2);
    } finally {
      isLoadingCart.value = false;
    }
  }
}
