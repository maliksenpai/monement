import 'package:hive_flutter/hive_flutter.dart';
import 'package:monement/model/adapters/color_adapter.dart';
import 'package:monement/model/expense/expense_category_item.dart';
import 'package:monement/model/expense/expense_item.dart';
import 'package:monement/model/investment/investment_item.dart';
import 'package:monement/model/settings_item.dart';
import 'package:monement/utils/constants.dart';

String investmentBox = "Investment";
String expensesBox = "Expenses";
String categoryBox = "Category";
String settingsBox = "Settings";

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseItemAdapter());
  Hive.registerAdapter(ExpenseCategoryItemAdapter());
  Hive.registerAdapter(InvestmentItemAdapter());
  Hive.registerAdapter(SettingsItemAdapter());
  Hive.registerAdapter(ColorAdapter());
  await initHiveBoxes();
  await Hive.openBox(expensesBox);
  await Hive.openBox(investmentBox);
}

Future<void> initHiveBoxes() async {
  await initCategories();
  await initSettings();
}

Future<void> initCategories() async {
  final box = await Hive.openBox<String>(categoryBox);
  if (box.isEmpty) {
    box.addAll(defaultCategories);
  }
}

Future<void> initSettings() async {
  final box = await Hive.openBox<SettingsItem>(settingsBox);
  if (box.isEmpty) {
    box.put("settings", defaultSettings);
  }
}

Future<void> restartHive() async {
  await Hive.deleteBoxFromDisk(expensesBox);
  await Hive.deleteBoxFromDisk(investmentBox);
  await Hive.deleteBoxFromDisk(settingsBox);
  await initHiveBoxes();
}
