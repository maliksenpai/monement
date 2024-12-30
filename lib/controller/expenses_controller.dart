import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:monement/database/hive_configuration.dart';
import 'package:monement/model/expense/expense_category_item.dart';
import 'package:monement/model/expense/expense_item.dart';
import 'package:monement/model/expense/expense_statistic_item.dart';
import 'package:monement/model/expense/expense_types.dart';

class ExpensesController extends GetxController {
  late ValueListenable<Box> expensesListenable;
  Rx<DateTime> currentDateTime = DateTime.now().obs;
  RxList<ExpenseItem> expenseItems = RxList.empty();
  Rx<ExpenseCategory?> selectedCategory = Rx(null);

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
  }

  RxMap<int, double> getMonthGroupedData() {
    Map<int, double> groupedData = {};
    for (var item in expenseItems) {
      int month = item.dateTime.month;
      double price = item.amount;
      if (groupedData.containsKey(month)) {
        groupedData[month] = groupedData[month]! + price;
      } else {
        groupedData[month] = price;
      }
    }
    return groupedData.obs;
  }

  RxList<ExpenseStatisticItem> getLastYearData() {
    final resultValue = getMonthGroupedData()
        .entries
        .map((entry) =>
            ExpenseStatisticItem(month: entry.key, amount: entry.value))
        .toList();
    final lastYearItems = resultValue.length > 12
        ? resultValue.sublist(resultValue.length - 12)
        : resultValue;
    return lastYearItems.obs;
  }

  RxMap<int, double> getCategoryGroupedData(List<ExpenseItem> expenseList) {
    Map<int, double> groupedData = {};
    for (var item in expenseList) {
      int category = item.category.index;
      double price = item.amount;
      if (groupedData.containsKey(category)) {
        groupedData[category] = groupedData[category]! + price;
      } else {
        groupedData[category] = price;
      }
    }
    return groupedData.obs;
  }

  RxList<ExpenseCategoryItem> getCurrentExpensesWithCategory() {
    List<ExpenseItem> expenses = getCurrentExpenseItem();
    RxMap<int, double> categoryMap = getCategoryGroupedData(expenses);

    return categoryMap.entries
        .map((entry) => ExpenseCategoryItem(
            amount: entry.value, category: ExpenseCategory.values[entry.key]))
        .toList()
        .obs;
  }

  RxList<ExpenseItem> getCurrentExpenseItem() {
    if (selectedCategory.value == null) {
      return RxList(expenseItems
          .where(
            (item) =>
                item.dateTime.year == currentDateTime.value.year &&
                item.dateTime.month == currentDateTime.value.month,
          )
          .toList());
    }
    return RxList(expenseItems
        .where(
          (item) =>
              item.dateTime.year == currentDateTime.value.year &&
              item.dateTime.month == currentDateTime.value.month &&
              item.category == selectedCategory.value,
        )
        .toList());
  }
}
