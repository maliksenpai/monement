import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:monement/components/expenses/add_category.dart';
import 'package:monement/controller/settings_controller.dart';
import 'package:monement/database/hive_configuration.dart';
import 'package:monement/model/expense/expense_item.dart';
import 'package:monement/utils/date.dart';
import 'package:monement/utils/random.dart';

class AddExpense extends StatefulWidget {
  final ExpenseItem? initialExpense;
  const AddExpense({super.key, this.initialExpense});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final SettingsController settingsController = Get.put(SettingsController());
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
      final totalItemCurrentCategory = box.values.fold(1, (total, item) {
        if (item.category == category) {
          total += 1;
        }
        return total;
      });
      final expenseItem = ExpenseItem(
        amount: double.parse(_amountController.text),
        category: category,
        dateTime: DateFormat(DATE_FORMAT).parse(_dateController.text),
        description: _descriptionController.text,
        name: _nameController.text != ""
            ? _nameController.text
            : "$category Expense - $totalItemCurrentCategory",
        key: widget.initialExpense != null
            ? widget.initialExpense!.key
            : generateRandomKey(),
      );

      if (widget.initialExpense != null) {
        box.put(widget.initialExpense!.key, expenseItem);
      } else {
        box.put(expenseItem.key, expenseItem);
      }

      Navigator.pop(context);
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
    if (widget.initialExpense != null) {
      _nameController.text = widget.initialExpense!.name;
      _descriptionController.text = widget.initialExpense!.description;
      _amountController.text = widget.initialExpense!.amount.toString();
      _dateController.text =
          DateFormat(DATE_FORMAT).format(widget.initialExpense!.dateTime);
      selectedCategory.first =
          categories.values.toList().indexOf(widget.initialExpense!.category);
    } else {
      _dateController.text = DateFormat(DATE_FORMAT).format(DateTime.now());
    }
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
                    listOfChipNames: [...categories.values, "Add Category +"],
                    listOfChipIndicesCurrentlySelected: selectedCategory,
                    inactiveTextColorList: [Theme.of(context).primaryColor],
                    elevation: 1,
                    shouldWrap: true,
                    shadowColor: [Theme.of(context).primaryColor],
                    showCheckmark: false,
                    activeBgColorList: [Theme.of(context).primaryColor],
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
