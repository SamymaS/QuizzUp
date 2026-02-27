import 'package:flutter/material.dart';
import '../models/game_history.dart';
import '../models/user_stats.dart';
import '../services/game_state_service.dart';
import '../utils/ux_constants.dart';
import '../widgets/stat_card.dart';
import 'category_selection_screen.dart';

class HomeScreenContent extends StatefulWidget {
  final String username;
  final bool isGuest;

  const HomeScreenContent({
    super.key,
    required this.username,
    this.isGuest = false,
  });

  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Bannière de bienvenue
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
                          widget.username,
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
          // Contenu principal
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
                    ValueListenableBuilder<UserStats>(
                      valueListenable: GameStateService.instance.stats,
                      builder: (context, stats, _) {
                        return Row(
                          children: [
                            Expanded(
                              child: StatCard(
                                icon: Icons.emoji_events,
                                value: '${stats.victories}',
                                label: 'Victoires',
                                color: UXConstants.warningColor,
                              ),
                            ),
                            SizedBox(width: UXConstants.standardSpacing),
                            Expanded(
                              child: StatCard(
                                icon: Icons.access_time,
                                value: '${stats.inProgress}',
                                label: 'En cours',
                                color: UXConstants.secondaryColor,
                              ),
                            ),
                            SizedBox(width: UXConstants.standardSpacing),
                            Expanded(
                              child: StatCard(
                                icon: Icons.trending_up,
                                value: '${stats.winRate.toInt()}%',
                                label: 'Taux',
                                color: UXConstants.accentColor,
                              ),
                            ),
                          ],
                        );
                      },
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
                    _GameModeSelector(isGuest: widget.isGuest),
                    SizedBox(height: UXConstants.largeSpacing),
                    // Section Duels en cours (empty state)
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
                          label: const Text('0'),
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
                    ValueListenableBuilder<UserStats>(
                      valueListenable: GameStateService.instance.stats,
                      builder: (context, stats, _) {
                        return Row(
                          children: [
                            Expanded(
                              child: StatCard(
                                icon: Icons.games,
                                value: '${stats.totalGames}',
                                label: 'Parties',
                                color: UXConstants.primaryColor,
                              ),
                            ),
                            SizedBox(width: UXConstants.standardSpacing),
                            Expanded(
                              child: StatCard(
                                icon: Icons.check_circle,
                                value: '${stats.totalWins}',
                                label: 'Gagnées',
                                color: UXConstants.accentColor,
                              ),
                            ),
                            SizedBox(width: UXConstants.standardSpacing),
                            Expanded(
                              child: StatCard(
                                icon: Icons.cancel,
                                value: '${stats.totalLosses}',
                                label: 'Perdues',
                                color: UXConstants.errorColor,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: UXConstants.largeSpacing),
                    // Historique
                    ValueListenableBuilder<List<GameHistory>>(
                      valueListenable: GameStateService.instance.history,
                      builder: (context, gameHistory, _) {
                        return Column(
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
                            if (gameHistory.isEmpty)
                              Container(
                                padding: UXConstants.cardPadding,
                                decoration: BoxDecoration(
                                  color: UXConstants.cardBackground,
                                  borderRadius: BorderRadius.circular(UXConstants.mediumRadius),
                                  border: Border.all(
                                    color: UXConstants.accentColor.withValues(alpha: 0.2),
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.history,
                                        size: 40,
                                        color: UXConstants.textSecondary.withValues(alpha: 0.4),
                                      ),
                                      SizedBox(height: UXConstants.minSpacing),
                                      Text(
                                        'Aucune partie jouée',
                                        style: TextStyle(
                                          color: UXConstants.textSecondary,
                                          fontSize: UXConstants.captionTextSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            else
                              ...gameHistory.take(3).map((game) => _HistoryCard(game: game)),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GameModeSelector extends StatefulWidget {
  final bool isGuest;
  const _GameModeSelector({this.isGuest = false});

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
              final navigator = Navigator.of(context);
              Future.delayed(const Duration(milliseconds: 300), () {
                if (mounted) {
                  navigator.push(
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
            onTap: widget.isGuest
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Créez un compte pour accéder au mode 1vs1 !'),
                        duration: UXConstants.shortAnimation,
                      ),
                    );
                  }
                : () {
                    setState(() {
                      _selectedMode = '1vs1';
                    });
                    final navigator = Navigator.of(context);
                    Future.delayed(const Duration(milliseconds: 300), () {
                      if (mounted) {
                        navigator.push(
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
                  if (widget.isGuest)
                    Icon(
                      Icons.lock_outline,
                      color: UXConstants.textSecondary.withValues(alpha: 0.5),
                      size: 24,
                    )
                  else if (_selectedMode == '1vs1')
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
          style: const TextStyle(
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
