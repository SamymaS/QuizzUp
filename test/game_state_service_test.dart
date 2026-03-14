import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quizzup/services/game_state_service.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    // Réinitialiser l'état singleton entre chaque test
    final service = GameStateService.instance;
    service.stats.value = service.stats.value.copyWith(
      victories: 0,
      totalGames: 0,
      totalWins: 0,
      totalLosses: 0,
      winRate: 0.0,
    );
    service.history.value = [];
    // Remettre les badges à leur état verrouillé initial
    service.badges.value = service.badges.value
        .map((b) => b.copyWith(isUnlocked: false, unlockedAt: null))
        .toList();
  });

  group('GameStateService.recordGame', () {
    test('incrémente totalGames après une partie', () async {
      await GameStateService.instance.recordGame(
        isWin: true,
        category: 'Sport',
        myScore: 8,
        opponentScore: 5,
        opponentName: 'Bot',
      );
      expect(GameStateService.instance.stats.value.totalGames, 1);
    });

    test('incrémente victories sur une victoire', () async {
      await GameStateService.instance.recordGame(
        isWin: true,
        category: 'Histoire',
        myScore: 7,
        opponentScore: 3,
        opponentName: 'Alice',
      );
      expect(GameStateService.instance.stats.value.victories, 1);
      expect(GameStateService.instance.stats.value.totalWins, 1);
      expect(GameStateService.instance.stats.value.totalLosses, 0);
    });

    test('incrémente totalLosses sur une défaite', () async {
      await GameStateService.instance.recordGame(
        isWin: false,
        category: 'Musique',
        myScore: 3,
        opponentScore: 7,
        opponentName: 'Bob',
      );
      expect(GameStateService.instance.stats.value.victories, 0);
      expect(GameStateService.instance.stats.value.totalLosses, 1);
    });

    test('winRate calculé correctement (2 victoires / 3 parties = 66%)', () async {
      for (var i = 0; i < 3; i++) {
        await GameStateService.instance.recordGame(
          isWin: i < 2,
          category: 'Sciences',
          myScore: i < 2 ? 8 : 3,
          opponentScore: i < 2 ? 3 : 8,
          opponentName: 'Bot',
        );
      }
      final rate = GameStateService.instance.stats.value.winRate;
      expect(rate, closeTo(66.66, 0.1));
    });

    test('ajoute une entrée dans l\'historique', () async {
      await GameStateService.instance.recordGame(
        isWin: true,
        category: 'Géographie',
        myScore: 9,
        opponentScore: 1,
        opponentName: 'Charlie',
      );
      expect(GameStateService.instance.history.value.length, 1);
      expect(GameStateService.instance.history.value.first.opponentName, 'Charlie');
    });

    test('l\'historique est en ordre antéchronologique', () async {
      await GameStateService.instance.recordGame(
        isWin: true,
        category: 'Sport',
        myScore: 6,
        opponentScore: 4,
        opponentName: 'Premier',
      );
      await GameStateService.instance.recordGame(
        isWin: false,
        category: 'Sport',
        myScore: 4,
        opponentScore: 6,
        opponentName: 'Second',
      );
      expect(GameStateService.instance.history.value.first.opponentName, 'Second');
    });
  });

  group('GameStateService — déblocage des badges', () {
    test('badge_1v se débloque à 1 victoire', () async {
      await GameStateService.instance.recordGame(
        isWin: true,
        category: 'Sport',
        myScore: 6,
        opponentScore: 4,
        opponentName: 'Bot',
      );
      final badge = GameStateService.instance.badges.value
          .firstWhere((b) => b.id == 'badge_1v');
      expect(badge.isUnlocked, true);
    });

    test('badge_5v ne se débloque pas avant 5 victoires', () async {
      for (var i = 0; i < 4; i++) {
        await GameStateService.instance.recordGame(
          isWin: true,
          category: 'Sport',
          myScore: 6,
          opponentScore: 4,
          opponentName: 'Bot',
        );
      }
      final badge = GameStateService.instance.badges.value
          .firstWhere((b) => b.id == 'badge_5v');
      expect(badge.isUnlocked, false);
    });

    test('badge_5v se débloque exactement à 5 victoires', () async {
      for (var i = 0; i < 5; i++) {
        await GameStateService.instance.recordGame(
          isWin: true,
          category: 'Sport',
          myScore: 6,
          opponentScore: 4,
          opponentName: 'Bot',
        );
      }
      final badge = GameStateService.instance.badges.value
          .firstWhere((b) => b.id == 'badge_5v');
      expect(badge.isUnlocked, true);
    });

    test('une défaite ne débloque pas de badge', () async {
      await GameStateService.instance.recordGame(
        isWin: false,
        category: 'Sport',
        myScore: 3,
        opponentScore: 7,
        opponentName: 'Bot',
      );
      final anyUnlocked =
          GameStateService.instance.badges.value.any((b) => b.isUnlocked);
      expect(anyUnlocked, false);
    });
  });
}
