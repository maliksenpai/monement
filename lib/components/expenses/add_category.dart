import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:monement/database/hive_configuration.dart';

void showAddCategoryDialog() {
  final TextEditingController categoryController = TextEditingController();
  final box = Hive.box<String>(categoryBox);

  Get.dialog(
    AlertDialog(
      title: const Text('Add Category'),
      content: TextField(
        controller: categoryController,
        decoration: const InputDecoration(
          hintText: 'Enter category name',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.closeAllSnackbars();
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (categoryController.text.trim().isEmpty) {
              Get.snackbar(
                'Error',
                'Category name cannot be empty!',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            } else if (box.values.any((category) =>
                category.toLowerCase() ==
                categoryController.text.trim().toLowerCase())) {
              Get.snackbar(
                'Error',
                'This category is already created!',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            } else {
              box.add(categoryController.text.trim());
              Get.back();
              Get.snackbar(
                'Success',
                'Category added successfully!',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            }
          },
          child: const Text('Save'),
        ),
      ],
    ),
  );
}
