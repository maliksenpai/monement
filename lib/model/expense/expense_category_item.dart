import 'package:hive/hive.dart';

part 'expense_category_item.g.dart';

@HiveType(typeId: 2)
class ExpenseCategoryItem {
  @HiveField(3)
  String category;
  @HiveField(4)
  double amount;

  ExpenseCategoryItem({
    required this.amount,
    required this.category,
  });
}
