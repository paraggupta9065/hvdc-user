import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:hvdc_user/controllers/auth_controller.dart';
import 'package:hvdc_user/models/cart.dart';
import 'package:hvdc_user/models/prescription.dart';
import 'package:hvdc_user/utils/routing.dart';
import 'package:hvdc_user/utils/toast.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/request_handler.dart';
import '../utils/urls.dart';
import 'cart_controller.dart';

class UploadPrescriptionC extends GetxController {
  CartController cartController = Get.put(CartController());

  RxBool isLoading = RxBool(false);
  final ImagePicker picker = ImagePicker();
  XFile? image;

  pickImageCamera() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      kShowSnackbar(title: "", message: "Please select image !");
    }
  }

  pickImageGallary() async {
    try {
      image = await picker.pickImage(source: ImageSource.camera);
      if (image == null) {
        kShowSnackbar(title: "", message: "Please select image !");
        return;
      }
      String endpoint = "/prescription/";
      String url = mainUrl + endpoint;

      String? token = getToken();

      var formData = FormData.fromMap({
        'prescription':
            await MultipartFile.fromFile(image!.path, filename: image!.name),
      });
      final response = await Dio().post(url,
          data: formData,
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ));
      if (response.statusCode == 201) {
        router.pop();
        router.pop();
        kShowSnackbar(title: "", message: response.data['detail']);
      }
    } catch (e) {
      kShowSnackbar(title: "", message: "Something went wrong!");
    }
  }

  List<Prescription> prescriptions = [];

  Future getPrescriptions() async {
    try {
      isLoading.value = true;

      String endpoint = "/prescription/";

      String? token = getToken();

      dynamic response = await ApiHelper.get(
        endpoint,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      dynamic rawPrescriptions = response['results'];
      prescriptions = List.generate(rawPrescriptions.length,
          (index) => Prescription.fromJson(rawPrescriptions[index]));
    } catch (e) {
      log(e.toString(), name: "raju");
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  RxBool isLoadingButton = RxBool(false);
  RxInt isLoadingButtonId = RxInt(0);

  Future addPrescriptionToCart(int id) async {
    try {
      isLoadingButton.value = true;
      isLoadingButtonId.value = id;
      cartController.isLoadingCart.value = true;

      String endpoint = "/prescription/add_to_cart/";

      String? token = getToken();

      dynamic response = await ApiHelper.post(
        endpoint,
        {"id": id},
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      dynamic rawCartItems = response['cart'];
      cartController.cart = CartModel.fromJson(rawCartItems);

      kShowSnackbar(title: "Sucess !", message: response['detail'].toString());
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString(), duration: 2);
    } finally {
      isLoadingButton.value = false;
      cartController.isLoadingCart.value = true;
      isLoadingButtonId.value = 0;
    }
  }
}
