import 'package:flutter/widgets.dart';

class DetailItemRow extends StatelessWidget {
  final String label;
  final String value;
  final Widget? valueWidget;
  final bool longValue;

  const DetailItemRow({super.key, required this.value, required this.label, this.longValue = false, this.valueWidget});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        if (value.isNotEmpty) ...[
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.normal),
              softWrap: longValue,
            ),
          ),
        ],
        if (valueWidget != null) ...[
          const SizedBox(width: 5),
          valueWidget!,
        ],
      ],
    );
  }
}
