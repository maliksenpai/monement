import 'package:hive/hive.dart';

part 'investment_item.g.dart';

@HiveType(typeId: 3)
class InvestmentItem {
  @HiveField(0)
  DateTime dateTime;
  @HiveField(1)
  String description;
  @HiveField(2)
  double amount;
  @HiveField(3)
  double currentInvestment;
  @HiveField(4)
  bool isIncreased;
  @HiveField(5)
  int key;

  InvestmentItem({
    required this.dateTime,
    required this.amount,
    required this.description,
    required this.currentInvestment,
    required this.isIncreased,
    required this.key,
  });
}
