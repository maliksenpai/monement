import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:monement/controller/expenses_controller.dart';
import 'package:monement/database/hive_configuration.dart';

class CategoryChipList extends StatefulWidget {
  const CategoryChipList({super.key});

  @override
  State<CategoryChipList> createState() => _CategoryChipListState();
}

class _CategoryChipListState extends State<CategoryChipList> {
  @override
  Widget build(BuildContext context) {
    final ExpensesController expensesController = Get.put(ExpensesController());
    final categories = Hive.box<String>(categoryBox).values.toList();

    return Column(
      children: [
        Text("Categories", style: Theme.of(context).textTheme.titleMedium),
        Obx(
          () => ChipList(
            listOfChipNames: [
              ...categories,
            ],
            listOfChipIndicesCurrentlySelected: [
              categories.indexOf(expensesController.selectedCategory.value!)
            ],
            inactiveTextColorList: [Theme.of(context).primaryColor],
            elevation: 1,
            shadowColor: [Theme.of(context).primaryColor],
            axis: Axis.horizontal,
            showCheckmark: false,
            activeBgColorList: [Theme.of(context).primaryColor],
            extraOnToggle: (int index) {
              setState(() {
                expensesController.selectedCategory.value = categories[index];
              });
            },
          ),
        ),
      ],
    );
  }
}
