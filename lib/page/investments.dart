import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:monement/components/investment/investment_list.dart';
import 'package:monement/components/investment/total_investment_circle.dart';
import 'package:monement/components/util/section_wrapper.dart';

class Investments extends StatefulWidget {
  const Investments({super.key});

  @override
  State<Investments> createState() => _InvestmentsState();
}

class _InvestmentsState extends State<Investments> {
  @override
  Widget build(BuildContext context) {
    return const SectionWrapper(
      title: "Investments",
      children: [
        TotalInvestmentCircle(),
        SizedBox(
          height: 8,
        ),
        InvestmentList(),
      ],
    );
  }
}
