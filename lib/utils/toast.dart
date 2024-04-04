import 'package:get/get.dart';

kShowSnackbar({
  required String title,
  required String message,
}) {
  Get.showSnackbar(GetSnackBar(
    title: title,
    message: message,
    duration: const Duration(seconds: 1),
  ));
}
