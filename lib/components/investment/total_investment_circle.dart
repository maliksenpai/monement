import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monement/controller/investment_controller.dart';
import 'package:monement/controller/settings_controller.dart';

class TotalInvestmentCircle extends StatelessWidget {
  const TotalInvestmentCircle({super.key});

  @override
  Widget build(BuildContext context) {
    final InvestmentController investmentController =
        Get.put(InvestmentController());
    final settingsController = Get.put(SettingsController());

    return Obx(
      () {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.indigo, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.trending_up,
                    color: Colors.white,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Total Investment",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "${investmentController.getTotalInvestment()}${settingsController.selectedCurrency.value}",
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [Colors.yellow, Colors.orangeAccent],
                    ).createShader(
                      const Rect.fromLTWH(0, 0, 200, 70),
                    ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 4,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Your current total investment",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white54,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
