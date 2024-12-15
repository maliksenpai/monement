import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monement/controller/expenses_controller.dart';
import 'package:monement/model/expense/expense_item.dart';
import 'package:monement/model/expense/expense_statistic_item.dart';

class StatisticsChart extends StatefulWidget {
  const StatisticsChart({super.key});

  @override
  State<StatisticsChart> createState() => _StatisticsChartState();
}

class _StatisticsChartState extends State<StatisticsChart> {
  final ExpensesController expensesController = Get.put(ExpensesController());

  List<ExpenseStatisticItem> getGroupedList(RxList<ExpenseItem> items) {
    Map<int, double> groupedData = {};
    for (var item in items) {
      int month = item.dateTime.month;
      double price = item.amount;
      if (groupedData.containsKey(month)) {
        groupedData[month] = groupedData[month]! + price;
      } else {
        groupedData[month] = price;
      }
    }
    final resultValue = groupedData.entries
        .map((entry) =>
            ExpenseStatisticItem(month: entry.key, amount: entry.value))
        .toList();
    final lastTwelveMonth = resultValue.length > 10
        ? resultValue.sublist(resultValue.length - 10)
        : resultValue;
    return lastTwelveMonth;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final items = expensesController.expenseItems;
      var groupedList = getGroupedList(items);
      final maxValue = groupedList.map((item) => item.amount).reduce(max);
      if (items.isEmpty) {
        return const Center(
          child: Text(
            "There is no expenses",
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        );
      }
      return Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 32, left: 0, right: 50),
        child: LineChart(
          LineChartData(
            borderData: FlBorderData(show: true),
            gridData: const FlGridData(show: true, drawVerticalLine: false),
            titlesData: FlTitlesData(
              show: true,
              topTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  reservedSize: 50,
                  getTitlesWidget: (value, meta) => Text('${value.toInt()}\$'),
                  showTitles: true,
                  interval: (maxValue / 8).ceilToDouble(),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  getTitlesWidget: (value, meta) => Text(
                    DateFormat("MMMM").format(
                      DateTime(
                        0,
                        value.toInt(),
                      ),
                    ),
                  ),
                  showTitles: true,
                  interval: 1,
                ),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      Colors.yellow.withOpacity(0.4),
                      Colors.amber.withOpacity(0.4),
                      Colors.yellowAccent.withOpacity(0.4),
                    ],
                  ),
                ),
                spots: groupedList
                    .map(
                      (item) => FlSpot(
                        item.month.toDouble(),
                        item.amount,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
