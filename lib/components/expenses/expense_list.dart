import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monement/components/expenses/show_expense_detail_modal.dart';
import 'package:monement/components/util/expand_button.dart';
import 'package:monement/components/util/item_card.dart';
import 'package:monement/components/util/list_animation_wrapper.dart';
import 'package:monement/controller/settings_controller.dart';
import 'package:monement/model/expense/expense_item.dart';

class ExpenseList extends StatefulWidget {
  final List<ExpenseItem> expenseItems;

  const ExpenseList({super.key, required this.expenseItems});

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  final settingsController = Get.put(SettingsController());
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    var expenseItems = widget.expenseItems;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LiveList(
          key: Key(expenseItems.length.toString()),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: isExpanded
              ? expenseItems.length
              : expenseItems.length.clamp(0, 5),
          reAnimateOnVisibility: false,
          itemBuilder: (context, index, animation) {
            return Obx(
              () => ListAnimationWrapper(
                animation: animation,
                child: _expenseItem(
                  expenseItems[expenseItems.length - index - 1],
                  context,
                  settingsController.selectedCurrency.value,
                ),
              ),
            );
          },
        ),
        if (expenseItems.isNotEmpty && expenseItems.length > 5)
          ExpandButton(
            isExpanded: isExpanded,
            onPresses: () => setState(() {
              isExpanded = !isExpanded;
            }),
          )
      ],
    );
  }
}

Widget _expenseItem(ExpenseItem item, BuildContext context, String? currency) {
  return ItemCard(
    title: item.name,
    dateTime: item.dateTime,
    trailingText: '${item.amount.toString()}$currency',
    subTitle: 'Category: ${item.category}',
    onTap: () {
      showExpenseDetailsModal(context, item);
    },
  );
}
