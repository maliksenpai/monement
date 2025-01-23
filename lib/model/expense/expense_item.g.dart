// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseItemAdapter extends TypeAdapter<ExpenseItem> {
  @override
  final int typeId = 0;

  @override
  ExpenseItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseItem(
      dateTime: fields[0] as DateTime,
      amount: fields[4] as double,
      name: fields[2] as String,
      category: fields[3] as String,
      description: fields[1] as String,
      key: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseItem obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.key)
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
      other is ExpenseItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
