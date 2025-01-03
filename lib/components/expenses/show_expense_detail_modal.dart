import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monement/components/util/detail_item_row.dart';
import 'package:monement/model/expense/expense_item.dart';

void showExpenseDetailsModal(BuildContext context, ExpenseItem expenseItem) {
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
            DetailItemRow(
              label: "Amount:",
              value: "\$${expenseItem.amount.toStringAsFixed(2)}",
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
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text("Close"),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
