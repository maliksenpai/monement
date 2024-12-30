import 'package:flutter/widgets.dart';

class DetailItemRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailItemRow({super.key, required this.value, required this.label});

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
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.normal),
            softWrap: false,
          ),
        ),
      ],
    );
  }
}
