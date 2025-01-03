import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monement/controller/investment_controller.dart';

class TotalInvestmentCircle extends StatelessWidget {
  const TotalInvestmentCircle({super.key});

  @override
  Widget build(BuildContext context) {
    final InvestmentController investmentController =
        Get.put(InvestmentController());

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.3,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.amberAccent,
          width: 20,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Total Investment",
            style: TextStyle(fontSize: 24),
          ),
          Text(
            "${investmentController.getTotalInvestment().toStringAsFixed(2)}\$",
            style: const TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
