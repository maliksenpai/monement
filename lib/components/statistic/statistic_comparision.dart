import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monement/controller/expenses_controller.dart';
import 'package:monement/controller/settings_controller.dart';

class StatisticComparision extends StatefulWidget {
  const StatisticComparision({super.key});

  @override
  State<StatisticComparision> createState() => _StatisticComparisionState();
}

class _StatisticComparisionState extends State<StatisticComparision> {
  final ExpensesController expensesController = Get.put(ExpensesController());
  final settingsController = Get.put(SettingsController());
  final currentDateTime = DateTime.now();

  double getAverageExpenseThisYear() {
    final totalValue = expensesController
        .getLastYearData()
        .fold(0.0, (total, item) => total += item.amount);
    return totalValue / expensesController.getLastYearData().length;
  }

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(vertical: 12, horizontal: 32);
    final titleStyle = TextStyle(
      fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
    );
    final thisMonthExpense = expensesController.expenseItems
        .where(
          (item) =>
              item.dateTime.year == currentDateTime.year &&
              item.dateTime.month == currentDateTime.month,
        )
        .toList()
        .fold(0.0, (total, item) => total += item.amount);
    final averageExpense = getAverageExpenseThisYear();
    final finalColor =
        averageExpense >= thisMonthExpense ? Colors.green : Colors.red;
    final compareAverageAndCurrent =
        ((averageExpense / thisMonthExpense) - 1) * 100;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: padding,
          width: double.infinity,
          child: Card(
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Your average spending in the last 12 months",
                  style: titleStyle,
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                ),
                Text(averageExpense.isNaN
                    ? "-"
                    : "${averageExpense.toStringAsFixed(2)}${settingsController.selectedCurrency.value}"),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: padding,
          width: double.infinity,
          child: Card(
            child: Obx(
              () => Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Your total spending this month",
                    style: titleStyle,
                  ),
                  Divider(
                    color: Theme.of(context).primaryColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        thisMonthExpense.isNaN
                            ? "-"
                            : "${thisMonthExpense.toStringAsFixed(2)}${settingsController.selectedCurrency.value}",
                        style: TextStyle(
                          color: finalColor,
                        ),
                      ),
                      if (!compareAverageAndCurrent.isNaN)
                        Row(
                          children: [
                            Icon(
                              finalColor == Colors.green
                                  ? Icons.arrow_downward
                                  : Icons.arrow_upward,
                              color: finalColor,
                            ),
                            Text(
                              '%${compareAverageAndCurrent.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: finalColor,
                              ),
                            )
                          ],
                        )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
