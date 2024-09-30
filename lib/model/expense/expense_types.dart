import 'package:hive/hive.dart';

part 'expense_types.g.dart';

@HiveType(typeId: 1)
enum ExpenseCategory {
  @HiveField(0)
  foodAndGroceries,

  @HiveField(1)
  restaurantAndCafe,

  @HiveField(2)
  transportation,

  @HiveField(3)
  fuelAndVehicle,

  @HiveField(4)
  rent,

  @HiveField(5)
  electricityBill,

  @HiveField(6)
  waterBill,

  @HiveField(7)
  gasBill,

  @HiveField(8)
  internetAndPhone,

  @HiveField(9)
  creditCardPayments,

  @HiveField(10)
  insurance,

  @HiveField(11)
  health,

  @HiveField(12)
  clothing,

  @HiveField(13)
  personalCare,

  @HiveField(14)
  entertainment,

  @HiveField(15)
  subscriptions,

  @HiveField(16)
  education,

  @HiveField(17)
  childExpenses,

  @HiveField(18)
  homeFurniture,

  @HiveField(19)
  travelAndVacation,

  @HiveField(20)
  petExpenses,

  @HiveField(21)
  giftsAndDonations,

  @HiveField(22)
  taxes,

  @HiveField(23)
  debtAndLoans,

  @HiveField(24)
  hobbies,

  @HiveField(25)
  investments,

  @HiveField(26)
  officeExpenses,

  @HiveField(27)
  loanInterests,

  @HiveField(28)
  repairsAndMaintenance,

  @HiveField(29)
  others
}
