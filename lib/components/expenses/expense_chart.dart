import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monement/components/expenses/selected_category_area.dart';
import 'package:monement/controller/expenses_controller.dart';
import 'package:monement/model/expense/expense_item.dart';
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
    return Obx(
      () {
        final categoryNotSelected =
            expensesController.selectedCategory.value == null;
        final items = categoryNotSelected
            ? expensesController.getCurrentExpensesWithCategory()
            : expensesController.getCurrentExpenseItem();
        final screenWidth = MediaQuery.sizeOf(context).width;

        if (items.isEmpty) {
          return const Center(
            child: Text(
              "There is no expenses in current month",
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: categoryNotSelected ? screenWidth * 1 : screenWidth * 0.6,
              height: 300,
              child: PieChart(
                swapAnimationDuration: const Duration(seconds: 2),
                PieChartData(
                  borderData: FlBorderData(show: true),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  pieTouchData: PieTouchData(
                    enabled: true,
                    touchCallback: (event, response) {
                      if (categoryNotSelected) {
                        if (response?.touchedSection?.props.first != null) {
                          final touchedSectionIndex =
                              response?.touchedSection?.props[1] as int;
                          expensesController.selectedCategory.value =
                              (items[touchedSectionIndex]).category;
                        }
                      }
                    },
                  ),
                  sections: items.map(
                    (item) {
                      return PieChartSectionData(
                        title: categoryNotSelected
                            ? item.category
                            : (item as ExpenseItem).name,
                        value: item.amount,
                        color: generateRandomColor(),
                        titlePositionPercentageOffset: 1.25,
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              width: categoryNotSelected ? screenWidth * 0 : screenWidth * 0.4,
              height: 300,
              child: !categoryNotSelected
                  ? SelectedCategoryArea()
                  : const SizedBox.shrink(),
            ),
          ],
        );
      },
    );
  }
}
