// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_types.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseCategoryAdapter extends TypeAdapter<ExpenseCategory> {
  @override
  final int typeId = 1;

  @override
  ExpenseCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExpenseCategory.foodAndGroceries;
      case 1:
        return ExpenseCategory.restaurantAndCafe;
      case 2:
        return ExpenseCategory.transportation;
      case 3:
        return ExpenseCategory.fuelAndVehicle;
      case 4:
        return ExpenseCategory.rent;
      case 5:
        return ExpenseCategory.electricityBill;
      case 6:
        return ExpenseCategory.waterBill;
      case 7:
        return ExpenseCategory.gasBill;
      case 8:
        return ExpenseCategory.internetAndPhone;
      case 9:
        return ExpenseCategory.creditCardPayments;
      case 10:
        return ExpenseCategory.insurance;
      case 11:
        return ExpenseCategory.health;
      case 12:
        return ExpenseCategory.clothing;
      case 13:
        return ExpenseCategory.personalCare;
      case 14:
        return ExpenseCategory.entertainment;
      case 15:
        return ExpenseCategory.subscriptions;
      case 16:
        return ExpenseCategory.education;
      case 17:
        return ExpenseCategory.childExpenses;
      case 18:
        return ExpenseCategory.homeFurniture;
      case 19:
        return ExpenseCategory.travelAndVacation;
      case 20:
        return ExpenseCategory.petExpenses;
      case 21:
        return ExpenseCategory.giftsAndDonations;
      case 22:
        return ExpenseCategory.taxes;
      case 23:
        return ExpenseCategory.debtAndLoans;
      case 24:
        return ExpenseCategory.hobbies;
      case 25:
        return ExpenseCategory.investments;
      case 26:
        return ExpenseCategory.officeExpenses;
      case 27:
        return ExpenseCategory.loanInterests;
      case 28:
        return ExpenseCategory.repairsAndMaintenance;
      case 29:
        return ExpenseCategory.others;
      default:
        return ExpenseCategory.foodAndGroceries;
    }
  }

  @override
  void write(BinaryWriter writer, ExpenseCategory obj) {
    switch (obj) {
      case ExpenseCategory.foodAndGroceries:
        writer.writeByte(0);
        break;
      case ExpenseCategory.restaurantAndCafe:
        writer.writeByte(1);
        break;
      case ExpenseCategory.transportation:
        writer.writeByte(2);
        break;
      case ExpenseCategory.fuelAndVehicle:
        writer.writeByte(3);
        break;
      case ExpenseCategory.rent:
        writer.writeByte(4);
        break;
      case ExpenseCategory.electricityBill:
        writer.writeByte(5);
        break;
      case ExpenseCategory.waterBill:
        writer.writeByte(6);
        break;
      case ExpenseCategory.gasBill:
        writer.writeByte(7);
        break;
      case ExpenseCategory.internetAndPhone:
        writer.writeByte(8);
        break;
      case ExpenseCategory.creditCardPayments:
        writer.writeByte(9);
        break;
      case ExpenseCategory.insurance:
        writer.writeByte(10);
        break;
      case ExpenseCategory.health:
        writer.writeByte(11);
        break;
      case ExpenseCategory.clothing:
        writer.writeByte(12);
        break;
      case ExpenseCategory.personalCare:
        writer.writeByte(13);
        break;
      case ExpenseCategory.entertainment:
        writer.writeByte(14);
        break;
      case ExpenseCategory.subscriptions:
        writer.writeByte(15);
        break;
      case ExpenseCategory.education:
        writer.writeByte(16);
        break;
      case ExpenseCategory.childExpenses:
        writer.writeByte(17);
        break;
      case ExpenseCategory.homeFurniture:
        writer.writeByte(18);
        break;
      case ExpenseCategory.travelAndVacation:
        writer.writeByte(19);
        break;
      case ExpenseCategory.petExpenses:
        writer.writeByte(20);
        break;
      case ExpenseCategory.giftsAndDonations:
        writer.writeByte(21);
        break;
      case ExpenseCategory.taxes:
        writer.writeByte(22);
        break;
      case ExpenseCategory.debtAndLoans:
        writer.writeByte(23);
        break;
      case ExpenseCategory.hobbies:
        writer.writeByte(24);
        break;
      case ExpenseCategory.investments:
        writer.writeByte(25);
        break;
      case ExpenseCategory.officeExpenses:
        writer.writeByte(26);
        break;
      case ExpenseCategory.loanInterests:
        writer.writeByte(27);
        break;
      case ExpenseCategory.repairsAndMaintenance:
        writer.writeByte(28);
        break;
      case ExpenseCategory.others:
        writer.writeByte(29);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
