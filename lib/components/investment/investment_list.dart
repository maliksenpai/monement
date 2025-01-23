import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:monement/components/investment/investment_list_item.dart';
import 'package:monement/components/util/expand_button.dart';
import 'package:monement/components/util/list_animation_wrapper.dart';
import 'package:monement/controller/investment_controller.dart';
import 'package:monement/controller/settings_controller.dart';

class InvestmentList extends StatefulWidget {
  const InvestmentList({super.key});

  @override
  State<InvestmentList> createState() => _InvestmentListState();
}

class _InvestmentListState extends State<InvestmentList> {
  bool isExpanded = false;
  final InvestmentController investmentController =
      Get.put(InvestmentController());
  final settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    var investmentItems = investmentController.investmentItems;
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LiveList(
            key: Key(investmentItems.length.toString()),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: isExpanded
                ? investmentItems.length
                : investmentItems.length.clamp(0, 5),
            reAnimateOnVisibility: false,
            itemBuilder: (context, index, animation) {
              return ListAnimationWrapper(
                animation: animation,
                child: Obx(
                  () => InvestmentListItem(
                    item: investmentItems[investmentItems.length - index - 1],
                    currency: settingsController.selectedCurrency.value,
                  ),
                ),
              );
            },
          ),
          if (investmentItems.isNotEmpty && investmentItems.length > 5)
            ExpandButton(
              isExpanded: isExpanded,
              onPresses: () => setState(() {
                isExpanded = !isExpanded;
              }),
            )
        ],
      );
    });
  }
}
