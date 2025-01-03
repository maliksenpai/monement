import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:monement/components/homepage/homepage_fab.dart';
import 'package:monement/page/expenses.dart';
import 'package:monement/page/investments.dart';
import 'package:monement/page/statistics.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: const [
            Expenses(),
            SizedBox(
              height: 50,
            ),
            Investments(),
            SizedBox(
              height: 50,
            ),
            Statistics(),
          ],
        ),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: HomepageFab(),
    );
  }
}
