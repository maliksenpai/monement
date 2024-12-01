import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monement/model/expense/expense_item.dart';
import 'package:monement/page/add_expense.dart';
import 'package:monement/utils/extensions.dart';

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
            _buildDetailRow("Name:", expenseItem.name),
            const SizedBox(height: 10),
            _buildDetailRow(
                "Amount:", "\$${expenseItem.amount.toStringAsFixed(2)}"),
            const SizedBox(height: 10),
            _buildDetailRow(
                "Category:", expenseItem.category.formattedName),
            const SizedBox(height: 10),
            _buildDetailRow(
                "Date:", DateFormat.yMMMMd().format(expenseItem.dateTime)),
            if (expenseItem.description.isNotEmpty) ...[
              const SizedBox(height: 10),
              _buildDetailRow("Description:", expenseItem.description!),
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

Widget _buildDetailRow(String label, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(width: 5),
      Expanded(
        child: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
    ],
  );
}
