import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Future<DateTime?> showMonthYearPickerDialog(BuildContext context) async {
  RxInt selectedYear = DateTime.now().year.obs;
  RxInt selectedMonth = DateTime.now().month.obs;

  return await Get.dialog<DateTime?>(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Select Month and Year",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Obx(
              () => DropdownButton<int>(
                value: selectedMonth.value,
                items: List.generate(
                  12,
                  (index) {
                    return DropdownMenuItem(
                      value: index + 1,
                      child: Text(
                        DateFormat.MMMM().format(DateTime(2000, index + 1)),
                      ),
                    );
                  },
                ),
                onChanged: (value) {
                  if (value != null) {
                    selectedMonth.value = value;
                  }
                },
                isExpanded: true,
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () => DropdownButton<int>(
                value: selectedYear.value,
                items: List.generate(
                  20,
                  (index) {
                    int year = DateTime.now().year - 10 + index;
                    return DropdownMenuItem(
                      value: year,
                      child: Text(year.toString()),
                    );
                  },
                ),
                onChanged: (value) {
                  if (value != null) {
                    selectedYear.value = value;
                  }
                },
                isExpanded: true,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Get.back(result: null),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    DateTime selectedDate = DateTime(
                      selectedYear.value,
                      selectedMonth.value,
                    );
                    Get.back(result: selectedDate);
                  },
                  child: const Text(
                    "OK",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
