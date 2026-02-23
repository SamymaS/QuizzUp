import 'package:flutter/material.dart';
import '../models/opponent.dart';
import '../utils/ux_constants.dart';

class OpponentCard extends StatelessWidget {
  final Opponent opponent;
  final VoidCallback onTap;

  const OpponentCard({
    super.key,
    required this.opponent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: UXConstants.cardBackground,
          borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
          border: Border.all(
            color: UXConstants.accentColor.withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 6,
          ),
          minVerticalPadding: 0,
          dense: true,
          leading: CircleAvatar(
            radius: 22,
            backgroundColor: UXConstants.primaryColor,
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 20,
            ),
          ),
          title: Row(
            children: [
              Flexible(
                child: Text(
                  opponent.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: UXConstants.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (opponent.isOnline) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: UXConstants.accentColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'En ligne',
                    style: TextStyle(
                      color: UXConstants.accentColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Row(
              children: [
                Icon(Icons.person, size: 12, color: UXConstants.textSecondary),
                const SizedBox(width: 3),
                Text(
                  '${opponent.wins}V - ${opponent.losses}D',
                  style: TextStyle(
                    fontSize: 11,
                    color: UXConstants.textSecondary,
                  ),
                ),
                const SizedBox(width: 10),
                Icon(Icons.trending_up, size: 12, color: UXConstants.textSecondary),
                const SizedBox(width: 3),
                Text(
                  '${opponent.winRate.toInt()}%',
                  style: TextStyle(
                    fontSize: 11,
                    color: UXConstants.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios, size: 18, color: UXConstants.textSecondary),
          onTap: onTap,
        ),
      ),
    );
  }
}
