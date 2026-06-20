import 'package:flutter/material.dart';

class ActionCategoryHeader extends StatelessWidget {
  final String title;
  final Color indicatorColor;

  const ActionCategoryHeader({
    super.key,
    required this.title,
    required this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
      child: Row(
        children: [
          // The vertical colored indicator line
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: indicatorColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}