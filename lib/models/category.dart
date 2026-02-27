import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String icon;
  final int questionCount;
  final Color color;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    this.questionCount = 0,
    required this.color,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    Color color;
    final hex = map['color_hex'] as String? ?? 'DC2626';
    try {
      color = Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      color = const Color(0xFFDC2626);
    }
    return Category(
      id: map['id']?.toString() ?? '',
      name: map['name'] as String,
      icon: map['icon'] as String? ?? '❓',
      questionCount: (map['question_count'] as num?)?.toInt() ?? 0,
      color: color,
    );
  }
}
