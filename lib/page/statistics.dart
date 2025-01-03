import 'package:flutter/material.dart';
import 'package:monement/components/statistic/statistic_comparision.dart';
import 'package:monement/components/statistic/statistics_chart.dart';
import 'package:monement/components/util/section_wrapper.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      title: "Statistics",
      children: [
        Text(
          "Monthly Expenses Chart",
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        Text(
          "Last 12 Months",
          style: Theme.of(context).textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.5,
          child: const StatisticsChart(),
        ),
        const StatisticComparision(),
      ],
    );
  }
}
