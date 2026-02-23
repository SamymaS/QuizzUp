import 'package:flutter/foundation.dart';
import '../models/user_stats.dart';
import '../models/game_history.dart';
import '../models/badge.dart';
import 'persistence_service.dart';

class GameStateService {
  GameStateService._();
  static final GameStateService instance = GameStateService._();

  final ValueNotifier<UserStats> stats = ValueNotifier(UserStats());
  final ValueNotifier<List<GameHistory>> history = ValueNotifier([]);
  final ValueNotifier<List<UserBadge>> badges = ValueNotifier(_defaultBadges());

  bool _initialized = false;

  static List<UserBadge> _defaultBadges() {
    return [
      UserBadge(
        id: 'badge_1v',
        name: 'Premier Duel',
        description: 'Gagnez votre premier duel',
        icon: '🏆',
      ),
      UserBadge(
        id: 'badge_5v',
        name: 'Série de 5',
        description: 'Gagnez 5 duels',
        icon: '🔥',
      ),
      UserBadge(
        id: 'badge_10v',
        name: 'Maître',
        description: 'Gagnez 10 duels',
        icon: '👑',
      ),
      UserBadge(
        id: 'badge_20v',
        name: 'Invincible',
        description: 'Gagnez 20 duels',
        icon: '💎',
      ),
    ];
  }

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    final loadedStats = await PersistenceService.loadStats();
    final loadedHistory = await PersistenceService.loadHistory();
    final loadedBadges = await PersistenceService.loadBadges();

    stats.value = loadedStats;
    history.value = loadedHistory;
    if (loadedBadges.isNotEmpty) {
      badges.value = loadedBadges;
    }
  }

  Future<void> recordGame({
    required bool isWin,
    required String category,
    required int myScore,
    required int opponentScore,
    required String opponentName,
  }) async {
    final oldStats = stats.value;
    final newTotalGames = oldStats.totalGames + 1;
    final newTotalWins = oldStats.totalWins + (isWin ? 1 : 0);
    final newTotalLosses = oldStats.totalLosses + (isWin ? 0 : 1);
    final newVictories = oldStats.victories + (isWin ? 1 : 0);
    final newWinRate = newTotalGames > 0
        ? (newTotalWins / newTotalGames) * 100
        : 0.0;

    final updatedStats = oldStats.copyWith(
      victories: newVictories,
      totalGames: newTotalGames,
      totalWins: newTotalWins,
      totalLosses: newTotalLosses,
      winRate: newWinRate,
    );

    final newEntry = GameHistory(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      opponentName: opponentName,
      category: category,
      playedAt: DateTime.now(),
      isWin: isWin,
      myScore: myScore,
      opponentScore: opponentScore,
      result: isWin ? 'Victoire' : 'Défaite',
    );

    final updatedHistory = [newEntry, ...history.value];

    stats.value = updatedStats;
    history.value = updatedHistory;

    _checkBadgeUnlocks(updatedStats);

    await PersistenceService.saveStats(updatedStats);
    await PersistenceService.saveHistory(updatedHistory);
    await PersistenceService.saveBadges(badges.value);
  }

  void _checkBadgeUnlocks(UserStats updatedStats) {
    final milestones = {
      'badge_1v': 1,
      'badge_5v': 5,
      'badge_10v': 10,
      'badge_20v': 20,
    };

    final currentBadges = List<UserBadge>.from(badges.value);
    bool changed = false;

    for (int i = 0; i < currentBadges.length; i++) {
      final badge = currentBadges[i];
      if (!badge.isUnlocked) {
        final threshold = milestones[badge.id];
        if (threshold != null && updatedStats.victories >= threshold) {
          currentBadges[i] = badge.copyWith(
            isUnlocked: true,
            unlockedAt: DateTime.now(),
          );
          changed = true;
        }
      }
    }

    if (changed) {
      badges.value = currentBadges;
    }
  }
}
