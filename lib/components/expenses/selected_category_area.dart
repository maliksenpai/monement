import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monement/controller/expenses_controller.dart';
import 'package:monement/controller/settings_controller.dart';

class SelectedCategoryArea extends StatelessWidget {
  SelectedCategoryArea({super.key});

  final ExpensesController expensesController = Get.put(ExpensesController());
  final settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    final int totalExpenseLength =
        expensesController.getCurrentExpenseItem().length;
    final double totalExpenses = expensesController
        .getCurrentExpenseItem()
        .map((item) => item.amount)
        .fold(0.0, (item, total) => total += item);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _itemRow(
            "Category",
            expensesController.selectedCategory.value ?? "Unknown",
            context,
          ),
          _itemRow(
            "Number of Expenses",
            totalExpenseLength.toString(),
            context,
          ),
          Obx(
            () => _itemRow(
              "Total Expenses",
              "${totalExpenses.toStringAsFixed(2)}${settingsController.selectedCurrency.value}",
              context,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                expensesController.selectedCategory.value = null;
              },
              child: const Text(
                "Clear",
                softWrap: false,
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _itemRow(String label, String value, BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }