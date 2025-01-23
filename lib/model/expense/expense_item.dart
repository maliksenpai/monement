import 'package:hive/hive.dart';
import 'package:monement/model/expense/expense_category_item.dart';

part 'expense_item.g.dart';

@HiveType(typeId: 0)
class ExpenseItem extends ExpenseCategoryItem {
  @HiveField(0)
  DateTime dateTime;
  @HiveField(1)
  String description;
  @HiveField(2)
  String name;
  @HiveField(5)
  int key;

  ExpenseItem({
    required this.dateTime,
    required super.amount,
    required this.name,
    required super.category,
    required this.description,
    required this.key,
  });
}
