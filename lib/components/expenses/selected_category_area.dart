import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monement/components/util/detail_item_row.dart';
import 'package:monement/controller/expenses_controller.dart';

class SelectedCategoryArea extends StatelessWidget {
  SelectedCategoryArea({super.key});

  final ExpensesController expensesController = Get.put(ExpensesController());

  @override
  Widget build(BuildContext context) {
    final int totalExpenseLength =
        expensesController.getCurrentExpenseItem().length;
    final double totalExpenses = expensesController
        .getCurrentExpenseItem()
        .map((item) => item.amount)
        .fold(0.0, (item, total) => total += item);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          DetailItemRow(
            value: totalExpenseLength.toString(),
            label: "Number of Expenses:",
          ),
          DetailItemRow(
            value: "${totalExpenses.toStringAsFixed(2)}\$",
            label: "Total Expenses:",
          ),
          ElevatedButton(
            onPressed: () {
              expensesController.selectedCategory.value = null;
            },
            child: const Text(
              "Clear",
              softWrap: false,
            ),
          )
        ],
      ),
    );
  }
}
