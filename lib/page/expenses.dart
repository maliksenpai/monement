import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:monement/components/expense_chart.dark.dart';
import 'package:monement/controller/expenses_controller.dart';
import 'package:monement/database/hive_configuration.dart';
import 'package:monement/model/expense/expense_item.dart';
import 'package:monement/utils/extensions.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List expenseItems = Hive.box(expensesBox).values.toList()
    ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  final ExpensesController expensesController = Get.put(ExpensesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateFormat.MMMM().format(expensesController.currentDateTime.value),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.calendar_today,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: const ExpenseChart(),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: expenseItems.reversed.map(
                  (item) {
                    ExpenseItem expenseItem = item as ExpenseItem;
                    return Card(
                      child: ListTile(
                        title: Text(expenseItem.name),
                        subtitle: Text(
                            'Category: ${expenseItem.category.formattedName}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              expenseItem.amount.toString(),
                              style: const TextStyle(fontSize: 18),
                            ),
                            const Icon(Icons.attach_money),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
