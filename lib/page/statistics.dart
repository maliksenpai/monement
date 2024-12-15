import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:monement/components/statistics_chart.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Statistics",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Monthly Expenses Chart", style: TextStyle(fontSize: Theme.of(context).textTheme.titleLarge?.fontSize),),
            Text("Last 10 Months", style: TextStyle(fontSize: Theme.of(context).textTheme.titleSmall?.fontSize)),
            Flexible(
              child: StatisticsChart(),
            ),
          ],
        ),
      ),
    );
  }
}
