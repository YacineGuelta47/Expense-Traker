import 'package:flutter/material.dart';

import '../models/expense_model.dart';

class ChartBar extends StatelessWidget {
  final Category category;
  final double heightFactor;

  const ChartBar({required this.category, required this.heightFactor, super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Column(
      spacing: 10,
      children: [
        Expanded(
          child: FractionallySizedBox(
            heightFactor: heightFactor,
            widthFactor: 1,
            alignment: Alignment.bottomCenter,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: isDark
                    ? Theme.of(context).colorScheme.onSecondaryContainer
                    : Theme.of(context).colorScheme.onPrimaryContainer,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
        Icon(
          categoryIcons[category],
          color: isDark
              ? Theme.of(context).colorScheme.onSecondaryContainer
              : Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ],
    );
  }
}
