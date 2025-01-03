import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:monement/controller/investment_controller.dart';
import 'package:monement/database/hive_configuration.dart';
import 'package:monement/model/investment/investment_item.dart';

class UpdateInvestment extends StatefulWidget {
  const UpdateInvestment({super.key});

  @override
  State<UpdateInvestment> createState() => _UpdateInvestmentState();
}

class _UpdateInvestmentState extends State<UpdateInvestment> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final InvestmentController investmentController =
      Get.put(InvestmentController());

  // Selected default increase investment
  List<bool> selectedToggle = [true, false];

  void handleToggle(index) {
    setState(() {
      if (selectedToggle.first) {
        selectedToggle = [false, true];
      } else {
        selectedToggle = [true, false];
      }
    });
  }

  void handleSave() {
    if (_formKey.currentState!.validate()) {
      Box box = Hive.box(investmentBox);
      double total = investmentController.getTotalInvestment();
      double amount = double.parse(_amountController.text);
      double currentInvestment =
          selectedToggle.first ? total + amount : total - amount;
      box.add(
        InvestmentItem(
            description: _descriptionController.text,
            dateTime: DateTime.now(),
            amount: amount,
            currentInvestment: currentInvestment),
      );
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Investment Updated"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
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
          child: Wrap(
            runSpacing: 20,
            children: [
              Wrap(
                runSpacing: 20,
                children: [
                  ToggleButtons(
                    isSelected: selectedToggle,
                    onPressed: handleToggle,
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.sizeOf(context).width * 0.45,
                      minHeight: 50,
                    ),
                    color: Colors.black,
                    selectedColor: Colors.white,
                    fillColor: selectedToggle.first ? Colors.green : Colors.red,
                    children: const [
                      Text(
                        "Increase Investment",
                      ),
                      Text(
                        "Decrease Investment",
                      )
                    ],
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
                      label: Text('Amount *'),
                      border: OutlineInputBorder(),
                    ),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.min(1,
                            errorText: 'Min value is 1'),
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
                  )
                ],
              ),
              ElevatedButton(
                onPressed: handleSave,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                  padding: const EdgeInsets.all(16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text(
                  "Save",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
