import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:monement/database/hive_configuration.dart';
import 'package:monement/utils/colors.dart';

class ExpenseChart extends StatefulWidget {
  const ExpenseChart({super.key});

  @override
  State<ExpenseChart> createState() => _ExpenseChartState();
}

class _ExpenseChartState extends State<ExpenseChart> {
  Box box = Hive.box(expensesBox);

  @override
  Widget build(BuildContext context) {
    return PieChart(PieChartData(
      borderData: FlBorderData(
        show: true,
      ),
      sectionsSpace: 0,
      centerSpaceRadius: 40,
      sections: box.values.map((item) {
        return PieChartSectionData(
          title: item.name,
          value: item.amount,
          color: generateRandomColor(),
          titlePositionPercentageOffset: 1.25
        );
      }).toList(),
    ));
  }
}
