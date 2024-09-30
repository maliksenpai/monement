import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class TabItem {
  String label;
  int id;
  IconData icon;

  TabItem({required this.label, required this.id, required this.icon});
}
