import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monement/components/investment/investment_item_detail_modal.dart';
import 'package:monement/model/investment/investment_item.dart';

class InvestmentListItem extends StatelessWidget {
  final InvestmentItem item;
  final String currency;

  const InvestmentListItem({
    super.key,
    required this.item,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final String date = DateFormat.yMMMMd().format(item.dateTime);
    final String actionText = item.isIncreased ? "Increased" : "Decreased";
    final Color actionColor = item.isIncreased ? Colors.green : Colors.red;

    return GestureDetector(
      onTap: () => showInvestmentDetailsModal(context, item),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: actionColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                item.isIncreased ? Icons.arrow_upward : Icons.arrow_downward,
                color: actionColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.description.isNotEmpty
                        ? item.description
                        : "$actionText Investment",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "${item.isIncreased ? "+" : "-"}${item.amount.toStringAsFixed(2)}$currency",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: actionColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
