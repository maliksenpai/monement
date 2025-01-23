import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:monement/components/util/detail_item_row.dart';
import 'package:monement/controller/settings_controller.dart';
import 'package:monement/model/investment/investment_item.dart';

void showInvestmentDetailsModal(
    BuildContext context, InvestmentItem investmentItem) {
  final settingsController = Get.put(SettingsController());

  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Investment Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => DetailItemRow(
                label: "Amount:",
                value:
                    "${investmentItem.amount.toStringAsFixed(2)}${settingsController.selectedCurrency.value}",
              ),
            ),
            const SizedBox(height: 10),
            DetailItemRow(
              label: "Date:",
              value: DateFormat.yMMMMd().format(investmentItem.dateTime),
            ),
            const SizedBox(height: 10),
            DetailItemRow(
              label: "Action:",
              valueWidget: Row(
                children: [
                  Icon(
                    investmentItem.isIncreased
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    color:
                        investmentItem.isIncreased ? Colors.green : Colors.red,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    investmentItem.isIncreased ? "Increased" : "Decreased",
                    style: TextStyle(
                      color: investmentItem.isIncreased
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ],
              ),
              value: "",
            ),
            if (investmentItem.description.isNotEmpty) ...[
              const SizedBox(height: 10),
              DetailItemRow(
                label: "Description:",
                value: investmentItem.description,
                longValue: true,
              ),
            ],
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text("Close"),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
