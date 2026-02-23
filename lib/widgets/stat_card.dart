import 'package:flutter/material.dart';
import '../utils/ux_constants.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final Color? bgColor;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor ?? UXConstants.cardBackground,
        borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
        border: Border.all(
          color: UXConstants.accentColor.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: UXConstants.cardPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: UXConstants.minSpacing),
          Text(
            value,
            style: TextStyle(
              fontSize: UXConstants.primaryTextSize,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: UXConstants.minSpacing / 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: UXConstants.smallTextSize,
              color: UXConstants.textSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
