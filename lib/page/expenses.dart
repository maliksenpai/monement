import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monement/components/expenses/expense_chart.dart';
import 'package:monement/components/expenses/month_and_year_select_dialog.dart';
import 'package:monement/components/expenses/show_expense_detail_modal.dart';
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
      expenseItems = RxList([...expensesController.getCurrentExpenseItem()]);
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
        body: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
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
            LiveList(
              key: Key(expenseItems.length.toString()),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: expenseItems.length,
              itemBuilder: (context, index, animation) {
                return FadeTransition(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOut, // Burada eğri tanımlanıyor
                  ),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    )
                        .chain(
                          CurveTween(curve: Curves.bounceInOut),
                        )
                        .animate(animation),
                    child: _expenseItem(
                        expenseItems[expenseItems.length - index - 1], context),
                  ),
                );
              },
            ),
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
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 90,
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  topLeft: Radius.circular(8),
                ),
              ),
            ),
          ),
          ListTile(
            leading: SizedBox(
              width: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.dateTime.day.toString(),
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.titleLarge?.fontSize,
                        color: Colors.white),
                  ),
                  Text(
                    DateFormat("MMMM").format(item.dateTime),
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            title: Text(item.name),
            subtitle: Text('Category: ${item.category.formattedName}'),
            trailing: Text(
              '\$${item.amount.toString()}',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    ),
  );
}
