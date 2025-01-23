import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monement/database/hive_configuration.dart';
import 'package:monement/page/homepage.dart';
import 'package:monement/theme.dart';

Future<void> main() async {
  await initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: themeData,
      dark: darkThemeData,
      initial: AdaptiveThemeMode.light,
      builder: (theme, _) {
        return GetMaterialApp(
          title: 'Monement',
          theme: theme,
          home: const Homepage(),
        );
      },
    );
  }
}
