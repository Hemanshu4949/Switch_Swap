import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class MappingCard extends StatefulWidget {
  final List<String> keys;
  final IconData iconLeft;
  final IconData iconRight;
  final String title;
  final String subtitle;
  final String? macroName;
  final String? actionName;
  final bool isActive;
  final bool isError;
  final ValueChanged<bool>? onToggle;

  const MappingCard({
    super.key,
    required this.keys,
    required this.iconLeft,
    required this.iconRight,
    required this.title,
    required this.subtitle,
    this.macroName,
    this.actionName,
    this.isActive = true,
    this.isError = false,
    this.onToggle,
  });

  @override
  State<MappingCard> createState() => _MappingCardState();
}

class _MappingCardState extends State<MappingCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Keys and Switch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.keys.map((key) => _buildKeyPill(key)).toList(),
                ),
              ),
              const SizedBox(width: 8),
              if (widget.isError)
                Icon(Icons.error_outline, color: AppColors.error)
              else if (widget.onToggle != null)
                Switch(
                  value: widget.isActive,
                  onChanged: widget.onToggle,
                  activeThumbColor: AppColors.primaryContainer,
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Row 2: Title and Expand Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: widget.isError ? AppColors.error : AppColors.onSurface,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
                color: AppColors.onSurfaceVariant,
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
              ),
            ],
          ),

          // Expandable Details
          if (_isExpanded) ...[
            const SizedBox(height: 16),
            const Divider(color: Color(0xFFEEEEEE), height: 1),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.iconLeft, size: 28, color: AppColors.onSurfaceVariant),
                const SizedBox(width: 16),
                Icon(Icons.arrow_forward, color: AppColors.secondaryContainer),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    widget.iconRight,
                    size: 28,
                    color: widget.isError ? AppColors.error : AppColors.primaryContainer,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (widget.macroName != null && widget.macroName!.isNotEmpty) ...[
              Text(
                'Macro: ${widget.macroName}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 4),
            ],
            if (widget.actionName != null && widget.actionName!.isNotEmpty) ...[
              Text(
                'Action: ${widget.actionName}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 4),
            ],
            Text(
              widget.subtitle,
              style: TextStyle(
                fontSize: 14,
                color: widget.isError ? AppColors.error : AppColors.onSurfaceVariant,
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildKeyPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.onSecondary,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}