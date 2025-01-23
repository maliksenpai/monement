// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsItemAdapter extends TypeAdapter<SettingsItem> {
  @override
  final int typeId = 4;

  @override
  SettingsItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsItem(
      currency: fields[0] as String,
      isDarkMode: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.currency)
      ..writeByte(1)
      ..write(obj.isDarkMode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
