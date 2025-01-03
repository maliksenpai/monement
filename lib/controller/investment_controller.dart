import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:monement/database/hive_configuration.dart';
import 'package:monement/model/investment/investment_item.dart';

class InvestmentController extends GetxController {
  late ValueListenable<Box> investmentListenable;
  RxList<InvestmentItem> investmentItems = RxList.empty();

  @override
  void onInit() {
    listenInvestmentBox();
    super.onInit();
  }

  void updateInvestmentsCallback() {
    updateInvestmentItems(Hive.box(investmentBox));
  }

  void updateInvestmentItems(Box box) {
    investmentItems.assignAll(box.values.cast<InvestmentItem>().toList());
  }

  void listenInvestmentBox() {
    final box = Hive.box(investmentBox);
    updateInvestmentItems(box);
    investmentListenable = box.listenable();
    investmentListenable.addListener(updateInvestmentsCallback);
  }

  double getTotalInvestment() {
    return investmentItems.map((item) => item.amount).fold(0.0, (total, item) => total += item);
  }
}