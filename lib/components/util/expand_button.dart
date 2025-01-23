import 'package:flutter/material.dart';

class ExpandButton extends StatelessWidget {
  final void Function() onPresses;
  final bool isExpanded;

  const ExpandButton({
    super.key,
    required this.isExpanded,
    required this.onPresses,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPresses,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isExpanded ? "Show less" : "Show all",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.blue),
          ),
          Icon(
            isExpanded
                ? Icons.arrow_drop_up_rounded
                : Icons.arrow_drop_down_rounded,
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
