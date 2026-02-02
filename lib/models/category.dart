import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String icon;
  final int questionCount;
  final Color color;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    this.questionCount = 0,
    required this.color,
  });
}
