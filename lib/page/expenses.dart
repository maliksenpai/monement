import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monement/components/expense_chart.dart';
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
  late RxList<ExpenseItem> expenseItems =
      expensesController.getCurrentExpenseItem();

  @override
  void initState() {
    super.initState();
    expenseItems.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    expenseItems.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateFormat.MMMM().format(expensesController.currentDateTime.value),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: expensesController.currentDateTime.value,
                firstDate: DateTime(2000),
                lastDate: DateTime(2025),
              );
              // todo: implementation for changing month
            },
            icon: const Icon(
              Icons.calendar_today,
            ),
          )
        ],
      ),
      body: Obx(
        () {
          return Column(
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
                          return Card(
                            child: ListTile(
                              title: Text(item.name),
                              subtitle: Text(
                                  'Category: ${item.category.formattedName}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    item.amount.toString(),
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  const Icon(Icons.attach_money),
                                ],
                              ),
                            ),
                          );
                        },
                      ).toList()
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
