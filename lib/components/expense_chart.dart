import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monement/controller/expenses_controller.dart';
import 'package:monement/utils/colors.dart';

class ExpenseChart extends StatefulWidget {
  const ExpenseChart({super.key});

  @override
  State<ExpenseChart> createState() => _ExpenseChartState();
}

class _ExpenseChartState extends State<ExpenseChart> {
  final ExpensesController expensesController = Get.put(ExpensesController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final items = expensesController.getCurrentExpenseItem();
      if (items.isEmpty) {
        return const Center(
          child: Text(
            "There is no expenses in current month",
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        );
      }

      return PieChart(
        PieChartData(
          borderData: FlBorderData(
            show: true,
          ),
          sectionsSpace: 0,
          centerSpaceRadius: 40,
          sections: items.map((item) {
            return PieChartSectionData(
              title: item.name,
              value: item.amount,
              color: generateRandomColor(),
              titlePositionPercentageOffset: 1.25,
            );
          }).toList(),
        ),
      );
    });
  }
}
