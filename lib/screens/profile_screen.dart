import 'package:flutter/material.dart';
import '../models/user_stats.dart';
import '../models/badge.dart';
import '../models/game_history.dart';
import '../utils/ux_constants.dart';
import '../widgets/ux_stat_card.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  
  ProfileScreen({
    super.key,
    required this.username,
  });

  final UserStats _stats = UserStats(
    victories: 12,
    inProgress: 5,
    winRate: 75.0,
    totalGames: 20,
    totalWins: 15,
    totalLosses: 5,
  );

  final List<UserBadge> _badges = [
    UserBadge(
      id: '1',
      name: 'Premier Duel',
      description: 'Gagnez votre premier duel',
      icon: '🏆',
      isUnlocked: true,
    ),
    UserBadge(
      id: '2',
      name: 'Série de 5',
      description: 'Gagnez 5 duels d\'affilée',
      icon: '🔥',
      isUnlocked: true,
    ),
    UserBadge(
      id: '3',
      name: 'Maître',
      description: 'Gagnez 10 duels',
      icon: '👑',
      isUnlocked: true,
    ),
    UserBadge(
      id: '4',
      name: 'Invincible',
      description: 'Gagnez 20 duels',
      icon: '💎',
      isUnlocked: false,
    ),
  ];

  final List<GameHistory> _history = [
    GameHistory(
      id: '1',
      opponentName: 'Alice',
      category: 'Culture Générale',
      playedAt: DateTime.now().subtract(const Duration(days: 1)),
      isWin: true,
      myScore: 8,
      opponentScore: 5,
      result: 'Victoire',
    ),
    GameHistory(
      id: '2',
      opponentName: 'Bob',
      category: 'Histoire',
      playedAt: DateTime.now().subtract(const Duration(days: 2)),
      isWin: false,
      myScore: 4,
      opponentScore: 7,
      result: 'Défaite',
    ),
    GameHistory(
      id: '3',
      opponentName: 'Charlie',
      category: 'Sciences',
      playedAt: DateTime.now().subtract(const Duration(days: 3)),
      isWin: true,
      myScore: 9,
      opponentScore: 6,
      result: 'Victoire',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UXConstants.lightBackground,
      appBar: AppBar(
        title: Text(
          'Profil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: UXConstants.secondaryTextSize,
            color: UXConstants.textPrimary,
          ),
        ),
        backgroundColor: UXConstants.cardBackground,
        elevation: 0,
        iconTheme: IconThemeData(color: UXConstants.textPrimary),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Retour',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête avec nom d'utilisateur
            Container(
              width: double.infinity,
              padding: UXConstants.cardPadding,
              color: UXConstants.cardBackground,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: UXConstants.primaryColor.withValues(alpha: 0.1),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: UXConstants.primaryColor,
                    ),
                  ),
                  SizedBox(height: UXConstants.standardSpacing),
                  Text(
                    username,
                    style: TextStyle(
                      fontSize: UXConstants.primaryTextSize,
                      fontWeight: FontWeight.bold,
                      color: UXConstants.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: UXConstants.standardSpacing),

            // Statistiques principales
            Padding(
              padding: UXConstants.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Statistiques',
                    style: TextStyle(
                      fontSize: UXConstants.secondaryTextSize,
                      fontWeight: FontWeight.bold,
                      color: UXConstants.textPrimary,
                    ),
                  ),
                  SizedBox(height: UXConstants.standardSpacing),
                  Row(
                    children: [
                      Expanded(
                        child: UXStatCard(
                          icon: Icons.emoji_events,
                          value: '${_stats.victories}',
                          label: 'Victoires',
                          color: UXConstants.warningColor,
                        ),
                      ),
                      SizedBox(width: UXConstants.standardSpacing),
                      Expanded(
                        child: UXStatCard(
                          icon: Icons.access_time,
                          value: '${_stats.inProgress}',
                          label: 'En cours',
                          color: UXConstants.secondaryColor,
                        ),
                      ),
                      SizedBox(width: UXConstants.standardSpacing),
                      Expanded(
                        child: UXStatCard(
                          icon: Icons.trending_up,
                          value: '${_stats.winRate.toInt()}%',
                          label: 'Taux',
                          color: UXConstants.accentColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: UXConstants.standardSpacing),
                  // Statistiques secondaires
                  Row(
                    children: [
                      Expanded(
                        child: UXStatCard(
                          icon: Icons.games,
                          value: '${_stats.totalGames}',
                          label: 'Parties',
                          color: UXConstants.primaryColor,
                        ),
                      ),
                      SizedBox(width: UXConstants.standardSpacing),
                      Expanded(
                        child: UXStatCard(
                          icon: Icons.check_circle,
                          value: '${_stats.totalWins}',
                          label: 'Gagnées',
                          color: UXConstants.accentColor,
                        ),
                      ),
                      SizedBox(width: UXConstants.standardSpacing),
                      Expanded(
                        child: UXStatCard(
                          icon: Icons.cancel,
                          value: '${_stats.totalLosses}',
                          label: 'Perdues',
                          color: UXConstants.errorColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: UXConstants.largeSpacing),

            // Badges
            Padding(
              padding: UXConstants.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Badges',
                    style: TextStyle(
                      fontSize: UXConstants.secondaryTextSize,
                      fontWeight: FontWeight.bold,
                      color: UXConstants.textPrimary,
                    ),
                  ),
                  SizedBox(height: UXConstants.standardSpacing),
                  SizedBox(
                    height: 130, // Augmenté pour éviter l'overflow
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _badges.length,
                      itemBuilder: (context, index) {
                        return _BadgeCard(badge: _badges[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: UXConstants.largeSpacing),

            // Historique
            Padding(
              padding: UXConstants.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Historique',
                        style: TextStyle(
                          fontSize: UXConstants.secondaryTextSize,
                          fontWeight: FontWeight.bold,
                          color: UXConstants.textPrimary,
                        ),
                      ),
                      if (_history.length > 3)
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Voir tout l\'historique - À venir'),
                                duration: UXConstants.shortAnimation,
                              ),
                            );
                          },
                          child: Text(
                            'Voir tout',
                            style: TextStyle(
                              color: UXConstants.primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: UXConstants.standardSpacing),
                  ..._history.take(3).map((game) => _HistoryCard(game: game)),
                ],
              ),
            ),
            SizedBox(height: UXConstants.largeSpacing),
          ],
        ),
      ),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  final UserBadge badge;

  const _BadgeCard({required this.badge});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(right: UXConstants.standardSpacing),
      elevation: badge.isUnlocked ? 3 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
      ),
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
            color: badge.isUnlocked ? UXConstants.cardBackground : UXConstants.lightBackground,
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
                  color: badge.isUnlocked ? null : UXConstants.textSecondary.withValues(alpha: 0.5),
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
                  color: badge.isUnlocked ? UXConstants.textPrimary : UXConstants.textSecondary.withValues(alpha: 0.5),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final GameHistory game;

  const _HistoryCard({required this.game});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: UXConstants.standardSpacing),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
      ),
      child: ListTile(
        minVerticalPadding: UXConstants.minSpacing,
        contentPadding: EdgeInsets.symmetric(
          horizontal: UXConstants.standardSpacing,
          vertical: UXConstants.minSpacing,
        ),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: game.isWin 
            ? UXConstants.accentColor.withValues(alpha: 0.15) 
            : UXConstants.errorColor.withValues(alpha: 0.15),
          child: Icon(
            game.isWin ? Icons.check : Icons.close,
            color: game.isWin ? UXConstants.accentColor : UXConstants.errorColor,
          ),
        ),
          title: Text(
            'vs ${game.opponentName}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: UXConstants.bodyTextSize,
              color: UXConstants.textPrimary,
            ),
          ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            '${game.category} • ${_formatDate(game.playedAt)}',
            style: TextStyle(
              fontSize: UXConstants.smallTextSize,
              color: UXConstants.textSecondary,
            ),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${game.myScore} - ${game.opponentScore}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: UXConstants.bodyTextSize,
                color: game.isWin ? UXConstants.accentColor : UXConstants.errorColor,
              ),
            ),
            Text(
              game.result ?? '',
              style: TextStyle(
                fontSize: UXConstants.smallTextSize,
                color: UXConstants.textSecondary,
              ),
            ),
          ],
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Détails du duel vs ${game.opponentName}'),
              duration: UXConstants.shortAnimation,
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return "Aujourd'hui";
    } else if (difference.inDays == 1) {
      return 'Hier';
    } else if (difference.inDays < 7) {
      return 'Il y a ${difference.inDays} jours';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
