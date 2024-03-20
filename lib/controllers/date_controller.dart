import 'package:get/get.dart';

class DateController extends GetxController {
  final selectedDate = Rx<DateTime>(DateTime.now());
  final RxList<bool> isClickTime = List.generate(9, (_) => false).obs;
}
