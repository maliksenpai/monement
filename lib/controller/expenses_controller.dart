import 'package:get/get.dart';

class ExpensesController extends GetxController {
  Rx<DateTime> currentDateTime = DateTime.now().obs;

  void increment(DateTime newDateTime) {
    currentDateTime.value = newDateTime;
  }
}
