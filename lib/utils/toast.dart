import 'package:get/get.dart';

kShowSnackbar({
  required String title,
  required String message,
  int duration = 1,
}) {
  Get.showSnackbar(GetSnackBar(
    title: title,
    message: message,
    duration: Duration(seconds: duration),
  ));
}
