import 'package:flutter/material.dart';
import 'package:monement/components/statistic/statistic_comparision.dart';
import 'package:monement/components/statistic/statistics_chart.dart';

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
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              "Monthly Expenses Chart",
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "Last 12 Months",
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.titleSmall?.fontSize,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.5,
              child: const StatisticsChart(),
            ),
            const StatisticComparision(),
          ],
        ),
      ),
    );
  }
}
