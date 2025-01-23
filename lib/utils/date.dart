import 'package:flutter/material.dart';

String DATE_FORMAT = "dd-MM-yyyy";

Future<DateTime?> getTimeFromDatePicker(context) async {
  try {
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
  } catch (e) {
    print('Error picking date: $e');
    return null;
  }
}
