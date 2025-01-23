import 'package:hive/hive.dart';

part 'settings_item.g.dart';

@HiveType(typeId: 4)
class SettingsItem {
  @HiveField(0)
  String currency;
  @HiveField(1)
  bool isDarkMode;

  SettingsItem({this.currency = "\$", this.isDarkMode = false});
}