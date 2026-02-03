import 'package:flutter/material.dart';
import '../models/duel.dart';
import '../models/game_history.dart';
import '../utils/ux_constants.dart';
import 'category_selection_screen.dart';

class HomeScreenContent extends StatelessWidget {
  final String username;
  
  const HomeScreenContent({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    final int victories = 12;
    final int inProgress = 5;
    final double winRate = 75.0;

    final List<Duel> pendingDuels = [
      Duel(
        id: '1',
        opponentName: 'Alice',
        category: 'Culture Générale',
        createdAt: null,
        isCompleted: false,
      ),
      Duel(
        id: '2',
        opponentName: 'Bob',
        category: 'Histoire',
        createdAt: null,
        isCompleted: false,
      ),
      Duel(
        id: '3',
        opponentName: 'Charlie',
        category: 'Sciences',
        createdAt: null,
        isCompleted: false,
      ),
    ];

    final List<GameHistory> gameHistory = [
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

    return SafeArea(
      child: Column(
        children: [
          // Bannière de bienvenue simplifiée
          DecoratedBox(
            decoration: BoxDecoration(
              color: UXConstants.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: UXConstants.primaryColor.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: UXConstants.screenPadding.horizontal,
                vertical: UXConstants.standardSpacing,
              ),
              child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                SizedBox(width: UXConstants.standardSpacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'BIENVENUE',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: UXConstants.smallTextSize,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: UXConstants.primaryTextSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ),
          ),
          // Contenu principal avec scroll indicator
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              thickness: 6,
              radius: const Radius.circular(10),
              child: SingleChildScrollView(
                padding: UXConstants.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Statistiques
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.emoji_events,
                          value: '$victories',
                          label: 'Victoires',
                          color: UXConstants.warningColor,
                        ),
                      ),
                      SizedBox(width: UXConstants.standardSpacing),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.access_time,
                          value: '$inProgress',
                          label: 'En cours',
                          color: UXConstants.secondaryColor,
                        ),
                      ),
                      SizedBox(width: UXConstants.standardSpacing),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.trending_up,
                          value: '${winRate.toInt()}%',
                          label: 'Taux',
                          color: UXConstants.accentColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: UXConstants.largeSpacing),
                  // Sélection de mode de jeu
                  Text(
                    'Choisir un mode de jeu',
                    style: TextStyle(
                      fontSize: UXConstants.secondaryTextSize,
                      fontWeight: FontWeight.bold,
                      color: UXConstants.textPrimary,
                    ),
                  ),
                  SizedBox(height: UXConstants.standardSpacing),
                  const _GameModeSelector(),
                  SizedBox(height: UXConstants.largeSpacing),
                  // Section Duels en cours
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Duels en cours',
                        style: TextStyle(
                          fontSize: UXConstants.secondaryTextSize,
                          fontWeight: FontWeight.bold,
                          color: UXConstants.textPrimary,
                        ),
                      ),
                      Chip(
                        label: Text('${pendingDuels.length}'),
                        backgroundColor: UXConstants.accentColor.withValues(alpha: 0.2),
                        labelStyle: TextStyle(
                          color: UXConstants.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: UXConstants.standardSpacing),
                  OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Liste des duels - À venir'),
                          duration: UXConstants.shortAnimation,
                        ),
                      );
                    },
                    icon: const Icon(Icons.list),
                    label: const Text('Voir tous les duels'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: UXConstants.primaryColor,
                      side: BorderSide(color: UXConstants.primaryColor, width: 2),
                      padding: UXConstants.buttonPadding,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
                      ),
                    ),
                  ),
                  SizedBox(height: UXConstants.largeSpacing),
                  // Scoreboard détaillé
                  Text(
                    'Scoreboard',
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
                        child: _buildStatCard(
                          icon: Icons.games,
                          value: '20',
                          label: 'Parties',
                          color: UXConstants.primaryColor,
                        ),
                      ),
                      SizedBox(width: UXConstants.standardSpacing),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.check_circle,
                          value: '15',
                          label: 'Gagnées',
                          color: UXConstants.accentColor,
                        ),
                      ),
                      SizedBox(width: UXConstants.standardSpacing),
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.cancel,
                          value: '5',
                          label: 'Perdues',
                          color: UXConstants.errorColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: UXConstants.largeSpacing),
                  // Historique
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
                      if (gameHistory.length > 3)
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
                  ...gameHistory.take(3).map((game) => _HistoryCard(game: game)),
                ],
              ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: UXConstants.cardBackground,
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
    );
  }
}

class _GameModeSelector extends StatefulWidget {
  const _GameModeSelector();
  
  @override
  State<_GameModeSelector> createState() => _GameModeSelectorState();
}

class _GameModeSelectorState extends State<_GameModeSelector> {
  String? _selectedMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Mode Solo
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedMode = 'solo';
              });
              Future.delayed(const Duration(milliseconds: 300), () {
                if (mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CategorySelectionScreen(
                        gameMode: 'solo',
                      ),
                    ),
                  );
                }
              });
            },
            borderRadius: BorderRadius.circular(UXConstants.largeRadius),
            child: Container(
              padding: UXConstants.cardPadding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(UXConstants.largeRadius),
                color: _selectedMode == 'solo' 
                  ? Colors.green.withValues(alpha: 0.1)
                  : UXConstants.cardBackground,
                border: Border.all(
                  color: _selectedMode == 'solo' 
                    ? Colors.green[700]! 
                    : UXConstants.accentColor.withValues(alpha: 0.3),
                  width: _selectedMode == 'solo' ? 3 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: _selectedMode == 'solo' ? 0.15 : 0.05),
                    blurRadius: _selectedMode == 'solo' ? 8 : 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: _selectedMode == 'solo' 
                        ? Colors.green[700]
                        : UXConstants.secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: UXConstants.standardSpacing),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Solo',
                          style: TextStyle(
                            fontSize: UXConstants.secondaryTextSize,
                            fontWeight: FontWeight.bold,
                            color: _selectedMode == 'solo' 
                              ? Colors.green[700]
                              : UXConstants.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Entraînez-vous seul',
                          style: TextStyle(
                            fontSize: UXConstants.captionTextSize,
                            color: UXConstants.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_selectedMode == 'solo')
                    Icon(
                      Icons.check_circle,
                      color: Colors.green[700],
                      size: 28,
                    )
                  else
                    Icon(
                      Icons.arrow_forward_ios,
                      color: UXConstants.textSecondary,
                      size: 20,
                    ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: UXConstants.standardSpacing),
        // Mode 1vs1
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedMode = '1vs1';
              });
              Future.delayed(const Duration(milliseconds: 300), () {
                if (mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CategorySelectionScreen(
                        gameMode: '1vs1',
                      ),
                    ),
                  );
                }
              });
            },
            borderRadius: BorderRadius.circular(UXConstants.largeRadius),
            child: Container(
              padding: UXConstants.cardPadding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(UXConstants.largeRadius),
                color: _selectedMode == '1vs1' 
                  ? Colors.green.withValues(alpha: 0.1)
                  : UXConstants.cardBackground,
                border: Border.all(
                  color: _selectedMode == '1vs1' 
                    ? Colors.green[700]! 
                    : UXConstants.accentColor.withValues(alpha: 0.3),
                  width: _selectedMode == '1vs1' ? 3 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: _selectedMode == '1vs1' ? 0.15 : 0.05),
                    blurRadius: _selectedMode == '1vs1' ? 8 : 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: _selectedMode == '1vs1' 
                        ? Colors.green[700]
                        : UXConstants.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.people,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: UXConstants.standardSpacing),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1vs1',
                          style: TextStyle(
                            fontSize: UXConstants.secondaryTextSize,
                            fontWeight: FontWeight.bold,
                            color: _selectedMode == '1vs1' 
                              ? Colors.green[700]
                              : UXConstants.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Défiez un ami en duel',
                          style: TextStyle(
                            fontSize: UXConstants.captionTextSize,
                            color: UXConstants.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_selectedMode == '1vs1')
                    Icon(
                      Icons.check_circle,
                      color: Colors.green[700],
                      size: 28,
                    )
                  else
                    Icon(
                      Icons.arrow_forward_ios,
                      color: UXConstants.textSecondary,
                      size: 20,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final GameHistory game;

  const _HistoryCard({required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: UXConstants.standardSpacing),
      decoration: BoxDecoration(
        color: UXConstants.cardBackground,
        borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
        border: Border.all(
          color: UXConstants.accentColor.withValues(alpha: 0.2),
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
        leading: CircleAvatar(
          backgroundColor: game.isWin
              ? UXConstants.accentColor.withValues(alpha: 0.2)
              : UXConstants.errorColor.withValues(alpha: 0.2),
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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              game.category,
              style: TextStyle(
                fontSize: UXConstants.smallTextSize,
                color: UXConstants.textSecondary,
              ),
            ),
            Text(
              '${game.myScore} - ${game.opponentScore}',
              style: TextStyle(
                fontSize: UXConstants.smallTextSize,
                color: UXConstants.textSecondary,
              ),
            ),
          ],
        ),
        trailing: Text(
          game.result ?? '',
          style: TextStyle(
            fontSize: UXConstants.smallTextSize,
            color: UXConstants.textSecondary,
          ),
        ),
      ),
    );
  }
}
