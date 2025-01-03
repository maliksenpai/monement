// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_category_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseCategoryItemAdapter extends TypeAdapter<ExpenseCategoryItem> {
  @override
  final int typeId = 2;

  @override
  ExpenseCategoryItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseCategoryItem(
      amount: fields[4] as double,
      category: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseCategoryItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseCategoryItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
