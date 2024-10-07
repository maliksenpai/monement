import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:monement/database/hive_configuration.dart';
import 'package:monement/model/expense/expense_item.dart';

class ExpensesController extends GetxController {
  Rx<DateTime> currentDateTime = DateTime.now().obs;
  RxList<ExpenseItem> expenseItems = RxList.empty();

  @override
  void onInit() {
    listenExpensesBox();
    super.onInit();
  }

  void listenExpensesBox() {
    final box = Hive.box(expensesBox);
    updateExpenseItems(box);
    box.listenable().addListener(() {
      updateExpenseItems(box);
    });
  }

  void updateExpenseItems(Box box) {
    expenseItems.value = box.values.cast<ExpenseItem>().toList();
  }

  void increment(DateTime newDateTime) {
    currentDateTime.value = newDateTime;
  }

  RxList<ExpenseItem> getCurrentExpenseItem() {
    return expenseItems
        .where(
          (item) =>
              item.dateTime.year == currentDateTime.value.year &&
              item.dateTime.month == currentDateTime.value.month,
        )
        .toList()
        .obs;
  }
}
