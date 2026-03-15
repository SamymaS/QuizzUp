import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:quizzup/models/category.dart';
import 'package:quizzup/models/user_stats.dart';
import 'package:quizzup/screens/quiz_result_screen.dart';
import 'package:quizzup/services/game_state_service.dart';

/// ─────────────────────────────────────────────────────────────
/// Tests widget de l'écran de résultat.
///
/// Objectif :
/// Vérifier que l'écran de résultat :
/// - affiche correctement une victoire ou une défaite
/// - affiche les bonnes informations de score
/// - enregistre correctement la partie dans GameStateService
///
/// Particularité technique :
/// L'écran contient beaucoup d'éléments verticaux.
/// En environnement de test, la taille par défaut est parfois
/// trop petite, ce qui provoque un overflow visuel.
///
/// Solution :
/// On agrandit la surface de test dans chaque testWidgets
/// puis on la réinitialise avec addTearDown().
///
/// Importance :
/// Cet écran clôt le parcours utilisateur du quiz
/// et met à jour les statistiques du joueur.
void main() {
  const category = Category(
    id: 'science',
    name: 'Science',
    icon: '🧪',
    questionCount: 10,
    color: Colors.blue,
  );

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    GameStateService.instance.stats.value = UserStats();
    GameStateService.instance.history.value = [];
    GameStateService.instance.badges.value = [];
  });

  /// Vérifie qu'un score égal ou supérieur à 50 %
  /// est interprété comme une victoire.
  testWidgets('affiche une victoire à partir de 50 %', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 2000));
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: QuizResultScreen(
          score: 5,
          totalQuestions: 10,
          category: category,
          gameMode: 'solo',
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Félicitations !'), findsOneWidget);
    expect(find.text('50% de bonnes réponses'), findsOneWidget);
    expect(find.textContaining('Science'), findsWidgets);
  });

  /// Vérifie qu'un score inférieur à 50 %
  /// est interprété comme une défaite.
  testWidgets('affiche une défaite sous 50 %', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 2000));
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: QuizResultScreen(
          score: 4,
          totalQuestions: 10,
          category: category,
          gameMode: 'solo',
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Dommage !'), findsOneWidget);
    expect(find.text('40% de bonnes réponses'), findsOneWidget);
  });

  /// Vérifie que l'écran enregistre bien la partie
  /// dans GameStateService dès son affichage.
  testWidgets('enregistre la partie dans GameStateService', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 2000));
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: QuizResultScreen(
          score: 7,
          totalQuestions: 10,
          category: category,
          gameMode: 'solo',
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(GameStateService.instance.history.value, hasLength(1));
    expect(GameStateService.instance.stats.value.totalGames, 1);
    expect(GameStateService.instance.stats.value.totalWins, 1);
    expect(GameStateService.instance.history.value.first.category, 'Science');
  });
}