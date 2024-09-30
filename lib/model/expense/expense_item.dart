import 'package:hive/hive.dart';
import 'package:monement/model/expense/expense_types.dart';

part 'expense_item.g.dart';

@HiveType(typeId: 0)
class ExpenseItem {
  @HiveField(0)
  DateTime dateTime;
  @HiveField(1)
  double amount;
  @HiveField(2)
  String description;
  @HiveField(3)
  String name;
  @HiveField(4)
  ExpenseCategory category;

  ExpenseItem({
    required this.dateTime,
    required this.amount,
    required this.name,
    required this.category,
    required this.description,
  });
}
