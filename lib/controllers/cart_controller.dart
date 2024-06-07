import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/cart.dart';
import '../utils/request_handler.dart';
import '../utils/toast.dart';
import 'auth_controller.dart';

class CartController extends GetxController {
  RxBool isLoadingCart = RxBool(false);
  CartModel? cart;
  final selectedDate =
      Rx<DateTime>(DateTime.now().add(const Duration(days: 1)));
  final List slots = [7, 8, 9, 10, 11, 12, 13, 14];
  RxInt selectedSlot = RxInt(9);

  TextEditingController codeTextEditingController = TextEditingController();
  Future getCart() async {
    try {
      isLoadingCart.value = true;
      codeTextEditingController.clear();
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
      if (cart!.cart.promocode != null) {
        codeTextEditingController.text = cart!.cart.promocode?.code ?? "";
      }
    } catch (e) {
      if (e.toString() == "not_found") {
      } else {
        kShowSnackbar(title: "Error !", message: e.toString());
      }
    } finally {
      isLoadingCart.value = false;
    }
  }

  Future addToCart({
    int? test,
    int? package,
  }) async {
    try {
      isLoadingCart.value = true;
      String endpoint = "/cart/";

      String? token = getToken();
      Map map = {};

      if (test != null) {
        map['test'] = test;
      }
      if (package != null) {
        map['package'] = package;
      }
      dynamic response = await ApiHelper.post(
        endpoint,
        map,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      dynamic rawCartItems = response['cart'];
      cart = CartModel.fromJson(rawCartItems);

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

      if (response['is_null'] ?? false) {
        cart = null;
      } else {
        dynamic rawCartItems = response['cart'];
        cart = CartModel.fromJson(rawCartItems);
      }

      kShowSnackbar(title: "Sucess !", message: response['detail'].toString());
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString(), duration: 2);
    } finally {
      isLoadingCart.value = false;
    }
  }

  Future clearCart() async {
    try {
      isLoadingCart.value = true;
      String endpoint = "/cart/clear/";

      String? token = getToken();

      dynamic response = await ApiHelper.delete(
        endpoint,
        {},
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      cart = null;
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString(), duration: 2);
    } finally {
      isLoadingCart.value = false;
    }
  }

  Future promocodeApply() async {
    try {
      isLoadingCart.value = true;
      String endpoint = "/cart/promocode/";

      String? token = getToken();
      Map map = {"code": codeTextEditingController.text};
      dynamic response = await ApiHelper.post(
        endpoint,
        map,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      dynamic rawCartItems = response['cart'];
      cart = CartModel.fromJson(rawCartItems);

      kShowSnackbar(title: "Sucess !", message: response['detail'].toString());
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString(), duration: 2);
    } finally {
      isLoadingCart.value = false;
    }
  }
}
