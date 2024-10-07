import 'package:flutter/material.dart';

String dateFormat = "dd-MM-yyyy";

Future<DateTime?> getTimeFromDatePicker(context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (pickedDate != null) {
    return pickedDate;
  }
  return null;
}

/*
Future<MonthYear?> showMonthYearPickerDialog(
    BuildContext context, DateTime currentDate) async {
  int tempSelectedMonth = currentDate.month;
  int tempSelectedYear = currentDate.year;
  List<int> years = List.generate(50, (index) => DateTime.now().year - index);

  final result = await showDialog<MonthYear?>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select Month and Year'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Ay Seçici
            DropdownButton<int>(
              value: tempSelectedMonth,
              items: List.generate(12, (index) {
                return DropdownMenuItem(
                  child: Text('${index + 1}'),
                  value: index + 1,
                );
              }),
              onChanged: (int? value) {
                tempSelectedMonth = value!;
              },
            ),
            // Yıl Seçici
            DropdownButton<int>(
              value: tempSelectedYear,
              items: years.map((int year) {
                return DropdownMenuItem(
                  value: year,
                  child: Text('$year'),
                );
              }).toList(),
              onChanged: (int? value) {
                tempSelectedYear = value!;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(
                  MonthYear(month: tempSelectedMonth, year: tempSelectedYear));
            },
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(null); // Seçim iptal edildi
            },
          ),
        ],
      );
    },
  );
  return result; // Seçilen Ay ve Yıl geri döndürülüyor
}

 */
