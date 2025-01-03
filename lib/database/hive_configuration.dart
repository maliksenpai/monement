import 'package:hive_flutter/hive_flutter.dart';
import 'package:monement/model/expense/expense_category_item.dart';
import 'package:monement/model/expense/expense_item.dart';
import 'package:monement/model/investment/investment_item.dart';
import 'package:monement/utils/constants.dart';

String investmentBox = "Investment";
String expensesBox = "Expenses";
String categoryBox = "Category";

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseItemAdapter());
  Hive.registerAdapter(ExpenseCategoryItemAdapter());
  Hive.registerAdapter(InvestmentItemAdapter());
  await initCategories();
  await Hive.openBox(expensesBox);
  await Hive.openBox(investmentBox);
}

Future<void> initCategories() async {
  final box = await Hive.openBox<String>(categoryBox);
  if (box.isEmpty) {
    box.addAll(defaultCategories);
  }
}