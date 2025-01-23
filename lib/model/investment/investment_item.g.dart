// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investment_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InvestmentItemAdapter extends TypeAdapter<InvestmentItem> {
  @override
  final int typeId = 3;

  @override
  InvestmentItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InvestmentItem(
      dateTime: fields[0] as DateTime,
      amount: fields[2] as double,
      description: fields[1] as String,
      currentInvestment: fields[3] as double,
      isIncreased: fields[4] as bool,
      key: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, InvestmentItem obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.currentInvestment)
      ..writeByte(4)
      ..write(obj.isIncreased)
      ..writeByte(5)
      ..write(obj.key);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvestmentItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
