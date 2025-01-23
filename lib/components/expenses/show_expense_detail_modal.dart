import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:monement/components/util/detail_item_row.dart';
import 'package:monement/controller/settings_controller.dart';
import 'package:monement/database/hive_configuration.dart';
import 'package:monement/model/expense/expense_item.dart';
import 'package:monement/page/add_expense.dart';

void showExpenseDetailsModal(BuildContext context, ExpenseItem expenseItem) {
  final settingsController = Get.put(SettingsController());

  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Expense Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            DetailItemRow(
              label: "Name:",
              value: expenseItem.name,
            ),
            const SizedBox(height: 10),
            Obx(
              () => DetailItemRow(
                label: "Amount:",
                value:
                    "${expenseItem.amount.toStringAsFixed(2)}${settingsController.selectedCurrency.value}",
              ),
            ),
            const SizedBox(height: 10),
            DetailItemRow(
              label: "Category:",
              value: expenseItem.category,
            ),
            const SizedBox(height: 10),
            DetailItemRow(
              label: "Date:",
              value: DateFormat.yMMMMd().format(expenseItem.dateTime),
            ),
            if (expenseItem.description.isNotEmpty) ...[
              const SizedBox(height: 10),
              DetailItemRow(
                label: "Description:",
                value: expenseItem.description,
              ),
            ],
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      style: IconButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        showRemoveExpenseDialog(context, expenseItem);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      style: IconButton.styleFrom(
                        side: const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                        Get.bottomSheet(
                          AddExpense(initialExpense: expenseItem),
                          isScrollControlled: true,
                        );
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text("Close"),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

void showRemoveExpenseDialog(BuildContext context, ExpenseItem expenseItem) {
  Get.dialog(
    AlertDialog(
      title: const Text("Confirmation"),
      content: const Text("Are you sure you want to delete this item?"),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text("No"),
        ),
        TextButton(
          onPressed: () {
            final box = Hive.box(expensesBox);
            box.delete(expenseItem.key);
            Get.back();
            Get.back();
          },
          child: const Text("Yes"),
        ),
      ],
    ),
  );
}
