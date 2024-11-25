import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:monement/database/hive_configuration.dart';
import 'package:monement/model/expense/expense_item.dart';
import 'package:monement/model/expense/expense_types.dart';
import 'package:monement/utils/date.dart';
import 'package:monement/utils/extensions.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  late ExpenseCategory _expenseCategory = ExpenseCategory.others;

  void handleSave() {
    if (_formKey.currentState!.validate()) {
      Box box = Hive.box(expensesBox);
      box.add(
        ExpenseItem(
          amount: double.parse(_amountController.text),
          category: _expenseCategory,
          dateTime: DateFormat(DATE_FORMAT).parse(_dateController.text),
          description: _descriptionController.text,
          name: _nameController.text,
        ),
      );
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Expense Created"),
          behavior: SnackBarBehavior.floating,
        ),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Expense',
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Flexible(
                  child: Wrap(
                    runSpacing: 20,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          label: Text('Name'),
                          border: OutlineInputBorder(),
                        ),
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
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
                      TextFormField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'),
                          )
                        ],
                        decoration: const InputDecoration(
                          label: Text('Amount'),
                          border: OutlineInputBorder(),
                        ),
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.min(1,
                                errorText: 'Min value is 1'),
                          ],
                        ),
                      ),
                      DropdownButtonFormField<ExpenseCategory>(
                        value: _expenseCategory,
                        decoration: const InputDecoration(
                          labelText: 'Select Category',
                          border: OutlineInputBorder(),
                        ),
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.required(),
                          ],
                        ),
                        items: ExpenseCategory.values
                            .map((ExpenseCategory category) {
                          return DropdownMenuItem<ExpenseCategory>(
                            value: category,
                            child: Text(category.formattedName
                                .toString()
                                .split('.')
                                .last),
                          );
                        }).toList(),
                        onChanged: (ExpenseCategory? newValue) {
                          setState(() {
                            _expenseCategory = newValue!;
                          });
                        },
                        selectedItemBuilder: (context) {
                          return ExpenseCategory.values.map((item) {
                            return Text(item.formattedName);
                          }).toList();
                        },
                        menuMaxHeight: 500,
                      ),
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
                          DateTime? pickedDate =
                              await getTimeFromDatePicker(context);
                          if (pickedDate != null) {
                            setState(() {
                              _dateController.text =
                                  DateFormat(DATE_FORMAT).format(pickedDate);
                            });
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: handleSave,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                  backgroundColor: Colors.amber,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
