import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/patient.dart';
import '../utils/request_handler.dart';
import '../utils/toast.dart';
import 'auth_controller.dart';

class PatientController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  RxBool isLoadingPatient = RxBool(false);
  RxInt selectedPatient = RxInt(0);
  RxInt selectedGender = RxInt(0);

  Future addPatientCart() async {
    try {
      isLoadingPatient.value = true;
      String endpoint = "/user/patient/";

      String? token = getToken();

      dynamic response = await ApiHelper.post(
        endpoint,
        {
          "name": name.text,
          "gender": selectedGender.value == 0
              ? "M"
              : selectedGender.value == 1
                  ? "F"
                  : "O",
          "phone_number": phone.text,
        },
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      await getPatientCart();
      Get.back();
      kShowSnackbar(title: "Sucess !", message: response['detail'].toString());
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString(), duration: 2);
    } finally {
      isLoadingPatient.value = false;
    }
  }

  List<Patient> patient = [];
  Future getPatientCart() async {
    try {
      isLoadingPatient.value = true;
      String endpoint = "/user/patient/";

      String? token = getToken();

      dynamic response = await ApiHelper.get(
        endpoint,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      List rawPatient = response['results'];
      patient = List.generate(
          rawPatient.length, (index) => Patient.fromJson(rawPatient[index]));
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString(), duration: 2);
    } finally {
      isLoadingPatient.value = false;
    }
  }
}
