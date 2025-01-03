import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monement/controller/expenses_controller.dart';

class StatisticsChart extends StatefulWidget {
  const StatisticsChart({super.key});

  @override
  State<StatisticsChart> createState() => _StatisticsChartState();
}

class _StatisticsChartState extends State<StatisticsChart> {
  final ExpensesController expensesController = Get.put(ExpensesController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final items = expensesController.expenseItems;
      if (items.isEmpty) {
        return const Center(
          child: Text(
            "There is no expenses",
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        );
      }
      var groupedList = expensesController.getLastYearData();
      final maxValue = groupedList.map((item) => item.amount).reduce(max);
      final safeMaxValue = max(maxValue * 1.25, 1.0);
      final minValue = groupedList.map((item) => item.amount).reduce(min);
      final safeMinValue = max(minValue * 0.75, 1.0);
      const kChartPadding = EdgeInsets.fromLTRB(16, 16, 36, 32);
      return Padding(
        padding: kChartPadding,
        child: LineChart(
          LineChartData(
            borderData: FlBorderData(show: true),
            gridData: const FlGridData(show: true, drawVerticalLine: false),
            minY: safeMinValue,
            maxY: safeMaxValue,
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
                  interval: (safeMaxValue / 8).ceilToDouble(),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  getTitlesWidget: (value, meta) => Text(
                    DateFormat("MMM").format(
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
