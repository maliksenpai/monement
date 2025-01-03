import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:monement/page/add_expense.dart';
import 'package:monement/page/update_investment.dart';

class HomepageFab extends StatefulWidget {
  HomepageFab({super.key});

  final _key = GlobalKey<ExpandableFabState>();

  @override
  State<HomepageFab> createState() => _HomepageFabState();
}

class _HomepageFabState extends State<HomepageFab> {
  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      key: widget._key,
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(Icons.add),
        fabSize: ExpandableFabSize.regular,
        foregroundColor: Colors.white,
        backgroundColor: Colors.amber,
        shape: const CircleBorder(),
      ),
      closeButtonBuilder: DefaultFloatingActionButtonBuilder(
        child: const Icon(Icons.close),
        fabSize: ExpandableFabSize.small,
        foregroundColor: Colors.amber,
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
      ),
      overlayStyle: ExpandableFabOverlayStyle(
        color: Colors.black.withOpacity(0.5),
      ),
      children: [
        FloatingActionButton.extended(
          label: const Text(
            "Add Expense",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.amber,
          onPressed: () {
            Get.bottomSheet(
              const AddExpense(),
              isScrollControlled: true,
            );
            widget._key.currentState?.toggle();
          },
        ),
        FloatingActionButton.extended(
          label: const Text(
            "Update Investment",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.amber,
          onPressed: () {
            Get.bottomSheet(
              const UpdateInvestment(),
              isScrollControlled: true,
            );
            widget._key.currentState?.toggle();
          },
        )
      ],
    );
  }
}