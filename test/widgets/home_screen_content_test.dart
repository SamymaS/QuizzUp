import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:quizzup/models/game_history.dart';
import 'package:quizzup/models/user_stats.dart';
import 'package:quizzup/screens/home_screen_content.dart';
import 'package:quizzup/services/game_state_service.dart';

/// ─────────────────────────────────────────────────────────────
/// Tests widget de l'écran d'accueil.
///
/// Objectif :
/// Vérifier que l'écran HomeScreenContent affiche correctement
/// les informations de l'utilisateur et applique les restrictions
/// liées au mode invité.
///
/// Ce qui est testé :
/// - l'affichage du pseudo et des modes de jeu
/// - l'affichage des statistiques
/// - le blocage du mode 1vs1 pour un invité
///
/// Importance :
/// Cet écran constitue le hub principal de navigation du joueur.
void main() {
  setUp(() {
    GameStateService.instance.stats.value = UserStats(
      victories: 4,
      inProgress: 1,
      winRate: 50,
      totalGames: 8,
      totalWins: 4,
      totalLosses: 4,
    );

    GameStateService.instance.history.value = [
      GameHistory(
        id: 'game_1',
        opponentName: 'Bot',
        category: 'Science',
        playedAt: DateTime.now(),
        isWin: true,
        myScore: 7,
        opponentScore: 4,
        result: 'Victoire',
      ),
    ];
  });

  /// Vérifie que l'écran d'accueil affiche bien
  /// le pseudo, les modes de jeu et les sections principales.
  testWidgets(
      'affiche le pseudo, les modes de jeu et les sections principales',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: HomeScreenContent(
            username: 'Melvin',
            isGuest: false,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Melvin'), findsOneWidget);
    expect(find.text('Solo'), findsOneWidget);
    expect(find.text('1vs1'), findsOneWidget);
    expect(find.textContaining('Score'), findsWidgets);
    expect(find.textContaining('Historique'), findsWidgets);
    expect(find.text('Science'), findsOneWidget);
  });

  /// Vérifie que les statistiques injectées dans GameStateService
  /// sont bien affichées à l'écran.
  testWidgets('affiche les statistiques issues du GameStateService',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: HomeScreenContent(
            username: 'Melvin',
            isGuest: false,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.textContaining('4'), findsWidgets);
    expect(find.textContaining('50'), findsWidgets);
    expect(find.textContaining('8'), findsWidgets);
  });

  /// Vérifie qu'un utilisateur invité ne peut pas
  /// accéder au mode 1vs1.
  ///
  /// Méthode :
  /// - on charge l'écran avec isGuest = true
  /// - on clique sur "1vs1"
  /// - on vérifie qu'un SnackBar s'affiche
  testWidgets('bloque le mode 1vs1 pour un invité', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: HomeScreenContent(
            username: 'Invité',
            isGuest: true,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.text('1vs1'));
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
  });
}