import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monement/components/expense_chart.dart';
import 'package:monement/components/month_and_year_select_dialog.dart';
import 'package:monement/components/show_expense_detail_modal.dart';
import 'package:monement/controller/expenses_controller.dart';
import 'package:monement/model/expense/expense_item.dart';
import 'package:monement/utils/extensions.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final ExpensesController expensesController = Get.put(ExpensesController());
  RxList<ExpenseItem> expenseItems = RxList<ExpenseItem>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      expenseItems.assignAll(expensesController.getCurrentExpenseItem());
      expenseItems.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      return Scaffold(
        appBar: AppBar(
          title: Text(
            DateFormat.yMMMM().format(expensesController.currentDateTime.value),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                DateTime? selectedDate =
                    await showMonthYearPickerDialog(context);
                ;
                if (selectedDate != null) {
                  expensesController.currentDateTime.value = selectedDate;
                }
              },
              icon: const Icon(
                Icons.calendar_today,
              ),
            )
          ],
        ),
        body: Column(
          children: [
            const Expanded(
              flex: 1,
              child: ExpenseChart(),
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (expenseItems.isNotEmpty)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Expense Items",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    const Divider(),
                    ...expenseItems.reversed.map(
                          (ExpenseItem item) {
                        return _expenseItem(item, context);
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

Widget _expenseItem(ExpenseItem item, BuildContext context) {
  return GestureDetector(
    onTap: () {
      showExpenseDetailsModal(context, item);
    },
    child: Card(
      child: ListTile(
        title: Text(item.name),
        subtitle: Text('Category: ${item.category.formattedName}'),
        trailing: Text(
          '\$${item.amount.toString()}',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    ),
  );
}
