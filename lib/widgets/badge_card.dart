import 'package:flutter/material.dart';
import '../models/badge.dart';
import '../utils/ux_constants.dart';

class BadgeCard extends StatelessWidget {
  final UserBadge badge;

  const BadgeCard({super.key, required this.badge});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: UXConstants.standardSpacing),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
        color: badge.isUnlocked ? UXConstants.cardBackground : UXConstants.lightBackground,
        border: Border.all(
          color: badge.isUnlocked
              ? UXConstants.primaryColor.withValues(alpha: 0.3)
              : UXConstants.textSecondary.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: badge.isUnlocked ? 0.08 : 0.03),
            blurRadius: badge.isUnlocked ? 6 : 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              badge.icon,
              style: TextStyle(
                fontSize: 36,
                color: badge.isUnlocked
                    ? null
                    : UXConstants.textSecondary.withValues(alpha: 0.5),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Flexible(
            child: Text(
              badge.name,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: badge.isUnlocked
                    ? UXConstants.textPrimary
                    : UXConstants.textSecondary.withValues(alpha: 0.5),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
