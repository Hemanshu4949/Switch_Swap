import 'package:flutter/material.dart';

class KeyMapModel {
  final String id;
  final List<String> keys;
  final IconData iconLeft;
  final IconData iconRight;
  final String title;
  final String subtitle;
  bool isActive; // Mutable so we can toggle it
  final bool isError;

  KeyMapModel({
    required this.id,
    required this.keys,
    required this.iconLeft,
    required this.iconRight,
    required this.title,
    required this.subtitle,
    this.isActive = true,
    this.isError = false,
  });
}