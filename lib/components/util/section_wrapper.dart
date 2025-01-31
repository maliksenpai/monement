import 'package:flutter/material.dart';

class SectionWrapper extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SectionWrapper(
      {super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Divider(
          color: Theme.of(context).primaryColor,
          thickness: 2,
        ),
        ...children,
      ],
    );
  }
}
