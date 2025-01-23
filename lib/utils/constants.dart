import 'package:flutter/material.dart';
import 'package:monement/model/settings_item.dart';
import 'package:monement/model/tab_item.dart';

final List<TabItem> tabItems = [
  TabItem(id: 0, label: "Settings", icon: Icons.settings),
  TabItem(id: 1, label: "Expenses", icon: Icons.monetization_on),
  TabItem(id: 2, label: "Investments", icon: Icons.trending_up),
  TabItem(id: 3, label: "Statistics", icon: Icons.stacked_bar_chart),
];

const EdgeInsets formPadding = EdgeInsets.only(left: 20, right: 20, top: 20);

final defaultCategories = ["Others"];

const List<String> currencyIcons = [
  "\$",    // USD
  "€",     // EUR
  "£",     // GBP
  "¥",     // JPY
  "A\$",   // AUD
  "C\$",   // CAD
  "Fr",    // CHF
  "₹",     // INR
  "NZ\$",  // NZD
  "₺",     // TRY
  "R\$",   // BRL
  "₽",     // RUB
  "₩",     // KRW
  "S\$",   // SGD
  "HK\$",  // HKD
  "SEK",    // SEK
  "NOK",    // NOK
  "Mex\$", // MXN
  "R",     // ZAR
];

final defaultSettings = SettingsItem();

