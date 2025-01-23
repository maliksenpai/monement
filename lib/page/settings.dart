import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:monement/controller/settings_controller.dart';
import 'package:monement/database/hive_configuration.dart';
import 'package:monement/model/settings_item.dart';
import 'package:monement/utils/constants.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final box = Hive.box<SettingsItem>(settingsBox);
  final settingsController = Get.put(SettingsController());
  late String selectedCurrency;
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    selectedCurrency =
        box.get("settings")?.currency ?? defaultSettings.currency;
    isDarkMode = box.get("settings")?.isDarkMode ?? defaultSettings.isDarkMode;
  }

  Future<void> updateSettings() async {
    settingsController.updateSettings(
      SettingsItem(currency: selectedCurrency, isDarkMode: isDarkMode),
      context,
    );
  }

  Future<void> _clearAllData() async {
    bool confirm = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Are you sure?"),
          content: const Text("Are you sure you want to delete all data?"),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () => Get.back(result: false),
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () => Get.back(result: false),
            ),
          ],
        );
      },
    );

    if (confirm) {
      await restartHive();
      Get.snackbar(
        "Success",
        "Delete completed",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _settingsText("Currency"),
                const SizedBox(height: 8),
                DropdownButton<String>(
                  value: selectedCurrency,
                  items: currencyIcons.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: SizedBox(
                        width: 100,
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedCurrency = newValue;
                      });
                      updateSettings();
                    }
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _settingsText("Dark Theme"),
                Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                    updateSettings();
                  },
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: _clearAllData,
              child: const Text("Delete All Data"),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _settingsText(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );
}
