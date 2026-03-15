import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:quizzup/models/badge.dart';
import 'package:quizzup/models/game_history.dart';
import 'package:quizzup/models/user_stats.dart';
import 'package:quizzup/services/persistence_service.dart';

/// ─────────────────────────────────────────────────────────────
/// Tests du PersistenceService.
///
/// Objectif :
/// Vérifier que les données utilisateur sont correctement
/// sauvegardées et relues depuis le stockage local.
///
/// Ce qui est testé :
/// - les statistiques utilisateur
/// - l'historique des parties
/// - les badges débloqués
///
/// Méthode :
/// On utilise SharedPreferences simulé avec setMockInitialValues({})
/// pour tester la persistance sans dépendre du vrai stockage du téléphone.
///
/// Importance :
/// Ces tests garantissent que la progression du joueur
/// est bien conservée entre deux sessions.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  /// Vérifie que les statistiques sauvegardées
  /// sont correctement relues ensuite.
  test('sauvegarde et recharge les statistiques', () async {
    final stats = UserStats(
      victories: 3,
      inProgress: 1,
      winRate: 75.0,
      totalGames: 4,
      totalWins: 3,
      totalLosses: 1,
    );

    await PersistenceService.saveStats(stats);
    final loaded = await PersistenceService.loadStats();

    expect(loaded.victories, 3);
    expect(loaded.inProgress, 1);
    expect(loaded.winRate, 75.0);
    expect(loaded.totalGames, 4);
    expect(loaded.totalWins, 3);
    expect(loaded.totalLosses, 1);
  });

  /// Vérifie que l'historique des parties est bien
  /// sauvegardé puis relu à l'identique.
  test('sauvegarde et recharge l’historique', () async {
    final history = [
      GameHistory(
        id: '1',
        opponentName: 'Bot',
        category: 'Science',
        playedAt: DateTime.parse('2026-03-15T10:00:00Z'),
        isWin: true,
        myScore: 8,
        opponentScore: 4,
        result: 'Victoire',
      ),
    ];

    await PersistenceService.saveHistory(history);
    final loaded = await PersistenceService.loadHistory();

    expect(loaded, hasLength(1));
    expect(loaded.first.opponentName, 'Bot');
    expect(loaded.first.category, 'Science');
    expect(loaded.first.isWin, true);
    expect(loaded.first.myScore, 8);
  });

  /// Vérifie que les badges débloqués sont correctement
  /// persistés et relus avec leur état complet.
  test('sauvegarde et recharge les badges', () async {
    final badges = [
      UserBadge(
        id: 'badge_1v',
        name: 'Premier Duel',
        description: 'Gagnez votre premier duel',
        icon: '🏆',
        isUnlocked: true,
        unlockedAt: DateTime.parse('2026-03-15T10:00:00Z'),
      ),
    ];

    await PersistenceService.saveBadges(badges);
    final loaded = await PersistenceService.loadBadges();

    expect(loaded, hasLength(1));
    expect(loaded.first.id, 'badge_1v');
    expect(loaded.first.isUnlocked, true);
    expect(loaded.first.unlockedAt, isNotNull);
  });
}