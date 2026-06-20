import 'package:flutter/material.dart';
import 'action_item.dart';

class ActionItemModel {
  final ActionItem? rawItem; // Reference to the database object
  
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String tagLabel;
  final Color tagColor;
  final String? codeSnippet;
  
  // Execution modifiers
  final int delayAfterMs;
  final int repeatCount;

  ActionItemModel({
    this.rawItem,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    this.tagLabel = '',
    this.tagColor = Colors.transparent,
    this.codeSnippet,
    this.delayAfterMs = 0,
    this.repeatCount = 1,
  });
}
