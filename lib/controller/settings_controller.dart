import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:monement/database/hive_configuration.dart';
import 'package:monement/model/settings_item.dart';
import 'package:monement/utils/constants.dart';

class SettingsController extends GetxController {
  final box = Hive.box<SettingsItem>(settingsBox);
  final selectedCurrency = ''.obs;
  final isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    selectedCurrency.value =
        box.get("settings")?.currency ?? defaultSettings.currency;
    isDarkMode.value =
        box.get("settings")?.isDarkMode ?? defaultSettings.isDarkMode;
  }

  Future<void> updateSettings(
      SettingsItem settingsItem, BuildContext context) async {
    box.put(
      "settings",
      settingsItem,
    );
    selectedCurrency.value = settingsItem.currency;
    isDarkMode.value = settingsItem.isDarkMode;
    AdaptiveTheme.of(context).toggleThemeMode(
      useSystem: false,
    );
  }
}
