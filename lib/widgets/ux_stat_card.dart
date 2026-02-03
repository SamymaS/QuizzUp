import 'package:flutter/material.dart';
import '../utils/ux_constants.dart';

/// Carte de statistique conforme aux lois UX
class UXStatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const UXStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      color: UXConstants.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
      ),
      child: Padding(
        padding: UXConstants.cardPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
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
              style: TextStyle(
                fontSize: UXConstants.smallTextSize,
                color: UXConstants.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
