import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monement/database/hive_configuration.dart';
import 'package:monement/page/page_tab.dart';
import 'package:monement/theme.dart';

Future<void> main() async {
  await initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: themeData,
      home: const PageTab(),
    );
  }
}
