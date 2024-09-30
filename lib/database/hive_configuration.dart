import 'package:hive_flutter/hive_flutter.dart';
import 'package:monement/model/expense/expense_item.dart';
import 'package:monement/model/expense/expense_types.dart';

String expensesBox = "Expenses";

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseItemAdapter());
  Hive.registerAdapter(ExpenseCategoryAdapter());
  await Hive.openBox(expensesBox);
}
