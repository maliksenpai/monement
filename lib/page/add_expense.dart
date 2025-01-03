import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:monement/components/expenses/add_category.dart';
import 'package:monement/database/hive_configuration.dart';
import 'package:monement/model/expense/expense_item.dart';
import 'package:monement/utils/date.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final categories = Hive.box<String>(categoryBox);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final List<int> selectedCategory = [0];

  void handleSave() {
    if (_formKey.currentState!.validate()) {
      Box box = Hive.box(expensesBox);
      final category = categories.values.toList()[selectedCategory.first];
      box.add(
        ExpenseItem(
          amount: double.parse(_amountController.text),
          category: category,
          dateTime: DateFormat(DATE_FORMAT).parse(_dateController.text),
          description: _descriptionController.text,
          name: _nameController.text != ""
              ? _nameController.text
              : "${category} Expense",
        ),
      );
      Get.back();
      Get.snackbar(
        "Success",
        "Expense Created",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  @override
  void initState() {
    _dateController.text = DateFormat(DATE_FORMAT).format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Get.theme.bottomSheetTheme.backgroundColor ?? Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0,2}'),
                  )
                ],
                decoration: const InputDecoration(
                  label: Text('Amount *'),
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.min(1, errorText: 'Min value is 1'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  label: Text('Name'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                minLines: 3,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  label: Text('Description'),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.calendar_today),
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(),
                  ],
                ),
                onTap: () async {
                  DateTime? pickedDate = await getTimeFromDatePicker(context);
                  if (pickedDate != null) {
                    setState(() {
                      _dateController.text =
                          DateFormat(DATE_FORMAT).format(pickedDate);
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              const Text(
                "Select Category",
                textAlign: TextAlign.start,
              ),
              ValueListenableBuilder(
                valueListenable: categories.listenable(),
                builder: (context, Box<String> box, _) {
                  return ChipList(
                    listOfChipNames: [
                      ...categories.values.toList(),
                      "Add Category"
                    ],
                    listOfChipIndicesCurrentlySelected: selectedCategory,
                    inactiveTextColorList: [Colors.amberAccent],
                    elevation: 1,
                    shouldWrap: true,
                    shadowColor: [Colors.amberAccent],
                    showCheckmark: false,
                    activeBgColorList: [Colors.amberAccent],
                    extraOnToggle: (int index) {
                      if (index == categories.values.length) {
                        showAddCategoryDialog();
                      } else {
                        setState(() {
                          selectedCategory.first = index;
                        });
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: handleSave,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                ),
                child: const Text("Save"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
