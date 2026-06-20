import 'package:flutter/material.dart';

class ExecutionLoopCard extends StatelessWidget {
  final bool isLoopActive;
  final int repeatCount;
  final ValueChanged<bool> onToggle;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ExecutionLoopCard({
    super.key,
    required this.isLoopActive,
    required this.repeatCount,
    required this.onToggle,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.repeat, color: colorScheme.secondary),
                  const SizedBox(width: 12),
                  Text(
                    'Execution Loop',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              Switch(
                value: isLoopActive,
                onChanged: onToggle,
                activeThumbColor: colorScheme.primary,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colorScheme.outlineVariant, width: 0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Repeat Count',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      color: colorScheme.onSurfaceVariant,
                      onPressed: onDecrement,
                    ),
                    Text(
                      '$repeatCount',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      color: colorScheme.onSurfaceVariant,
                      onPressed: onIncrement,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}