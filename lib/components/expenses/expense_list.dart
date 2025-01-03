import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:monement/components/expenses/show_expense_detail_modal.dart';
import 'package:monement/model/expense/expense_item.dart';

class ExpenseList extends StatelessWidget {
  final List<ExpenseItem> expenseItems;
  ExpenseList({super.key, required this.expenseItems});

  @override
  Widget build(BuildContext context) {
    return LiveList(
      key: Key(expenseItems.length.toString()),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: expenseItems.length,
      reAnimateOnVisibility: false,
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
    );
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
            subtitle: Text('Category: ${item.category}'),
            trailing: Text(
              '${item.amount.toString()}\$',
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    ),
  );
}

