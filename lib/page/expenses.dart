import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monement/components/expenses/expense_chart.dart';
import 'package:monement/components/expenses/expense_list.dart';
import 'package:monement/components/expenses/month_and_year_select_dialog.dart';
import 'package:monement/components/util/section_wrapper.dart';
import 'package:monement/controller/expenses_controller.dart';
import 'package:monement/model/expense/expense_item.dart';

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
      expenseItems = RxList([...expensesController.getCurrentExpenseItem()]);
      expenseItems.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      return SectionWrapper(
        title: "Expenses",
        children: [
          Text(
            DateFormat.yMMMM().format(expensesController.currentDateTime.value),
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () async {
              DateTime? selectedDate = await showMonthYearPickerDialog(context);
              if (selectedDate != null) {
                expensesController.currentDateTime.value = selectedDate;
              }
            },
            child: const Wrap(
              children: [
                Text("Change Date"),
                Icon(
                  Icons.calendar_today,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.3,
            child: const ExpenseChart(),
          ),
          if (expenseItems.isNotEmpty)
            const Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Expense Items",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Divider(),
              ],
            ),
          ExpenseList(
            expenseItems: expenseItems,
          ),
        ],
      );
    });
  }
}
