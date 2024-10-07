import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:monement/model/tab_item.dart';
import 'package:monement/page/add_expense.dart';
import 'package:monement/page/expenses.dart';
import 'package:monement/page/investments.dart';
import 'package:monement/page/settings.dart';
import 'package:monement/page/statistics.dart';
import 'package:monement/utils/constants.dart';

class PageTab extends StatefulWidget {
  const PageTab({super.key});

  @override
  State<PageTab> createState() => _PageTabState();
}

class _PageTabState extends State<PageTab> {
  TabItem selectedTabItem = tabItems[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: switch (selectedTabItem.id) {
          0 => const Settings(),
          1 => const Expenses(),
          2 => const Investments(),
          3 => const Statistics(),
          int() => throw UnimplementedError(),
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Get.to(const AddExpense());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: tabItems.length,
        tabBuilder: (int index, bool isActive) {
          return Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isActive ? Colors.amber : Colors.transparent,
                  ),
                  child: Icon(
                    tabItems[index].icon,
                    color: isActive ? Colors.white : Colors.amber,
                  ),
                ),
                Text(tabItems[index].label),
              ],
            ),
          );
        },
        activeIndex: selectedTabItem.id,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        onTap: (index) {
          setState(() => selectedTabItem = tabItems[index]);
        },
        //other params
      ),
    );
  }
}
