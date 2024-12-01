import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:monement/database/hive_configuration.dart';
import 'package:monement/model/expense/expense_item.dart';

class ExpensesController extends GetxController {
  late ValueListenable<Box> expensesListenable;
  Rx<DateTime> currentDateTime = DateTime.now().obs;
  RxList<ExpenseItem> expenseItems = RxList.empty();

  @override
  void onInit() {
    listenExpensesBox();
    super.onInit();
  }

  void updateExpensesCallback() {
    updateExpenseItems(Hive.box(expensesBox));
  }

  @override
  void onClose() {
    expensesListenable.removeListener(updateExpensesCallback);
    super.onClose();
  }

  void listenExpensesBox() {
    final box = Hive.box(expensesBox);
    updateExpenseItems(box);
    expensesListenable = box.listenable();
    expensesListenable.addListener(updateExpensesCallback);
  }

  void updateExpenseItems(Box box) {
    expenseItems.assignAll(box.values.cast<ExpenseItem>().toList());
    expenseItems.refresh();
  }

  RxList<ExpenseItem> getCurrentExpenseItem() {
    return RxList(
      expenseItems
          .where(
            (item) =>
                item.dateTime.year == currentDateTime.value.year &&
                item.dateTime.month == currentDateTime.value.month,
          )
          .toList(),
    );
  }
}
