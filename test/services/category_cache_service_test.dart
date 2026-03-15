import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:quizzup/models/category.dart';
import 'package:quizzup/models/question.dart';
import 'package:quizzup/services/category_cache_service.dart';

/// ─────────────────────────────────────────────────────────────
/// Tests du CategoryCacheService.
///
/// Objectif :
/// Vérifier que les catégories et les questions sont correctement
/// stockées et relues depuis le cache local.
///
/// Méthode :
/// - utilisation de SharedPreferences simulé
/// - sauvegarde de données fictives
/// - relecture et comparaison des valeurs
///
/// Importance :
/// Ce service permet de limiter les appels réseau
/// et d'améliorer la réactivité de l'application.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('CategoryCacheService', () {
    /// Vérifie que les catégories peuvent être enregistrées
    /// puis relues correctement depuis le cache local.
    test('saveCategories + getCategories', () async {
      final service = CategoryCacheService.instance;

      final categories = [
        const Category(
          id: 'science',
          name: 'Science',
          icon: '🧪',
          questionCount: 12,
          color: Colors.blue,
        ),
      ];

      await service.saveCategories(categories);
      final loaded = await service.getCategories();

      expect(loaded, isNotNull);
      expect(loaded, hasLength(1));
      expect(loaded!.first.id, 'science');
      expect(loaded.first.name, 'Science');
      expect(loaded.first.icon, '🧪');
      expect(loaded.first.questionCount, 12);
    });

    /// Vérifie que les questions d'une catégorie
    /// peuvent être enregistrées puis relues correctement.
    test('saveQuestions + getQuestions', () async {
      final service = CategoryCacheService.instance;

      final questions = [
        Question(
          id: 'q1',
          category: 'science',
          question: 'Combien font 2 + 2 ?',
          answers: const ['1', '2', '3', '4'],
          correctAnswerIndex: 3,
          difficulty: Difficulty.easy,
          explanation: '2 + 2 = 4',
        ),
      ];

      await service.saveQuestions('science', questions);
      final loaded = await service.getQuestions('science');

      expect(loaded, isNotNull);
      expect(loaded, hasLength(1));
      expect(loaded!.first.id, 'q1');
      expect(loaded.first.category, 'science');
      expect(loaded.first.question, 'Combien font 2 + 2 ?');
      expect(loaded.first.answers, ['1', '2', '3', '4']);
      expect(loaded.first.correctAnswerIndex, 3);
      expect(loaded.first.difficulty, Difficulty.easy);
      expect(loaded.first.explanation, '2 + 2 = 4');
    });

    /// Vérifie que getQuestionsStale() retourne les questions
    /// sans appliquer de contrôle de fraîcheur.
    test('getQuestionsStale retourne les questions sans vérifier le TTL', () async {
      final service = CategoryCacheService.instance;

      final questions = [
        Question(
          id: 'q2',
          category: 'history',
          question: 'En quelle année a eu lieu 1789 ?',
          answers: const ['1789', '1889', '1492', '1914'],
          correctAnswerIndex: 0,
          difficulty: Difficulty.medium,
        ),
      ];

      await service.saveQuestions('history', questions);

      final loaded = await service.getQuestionsStale('history');

      expect(loaded, isNotNull);
      expect(loaded, hasLength(1));
      expect(loaded!.first.id, 'q2');
    });

    /// Vérifie que l'invalidation supprime bien
    /// les catégories et les questions du cache.
    test('invalidateAll supprime le cache catégories et questions', () async {
      final service = CategoryCacheService.instance;

      await service.saveCategories([
        const Category(
          id: 'geo',
          name: 'Géographie',
          icon: '🌍',
          questionCount: 5,
          color: Colors.green,
        ),
      ]);

      await service.saveQuestions('geo', [
        Question(
          id: 'q3',
          category: 'geo',
          question: 'Capitale de la France ?',
          answers: const ['Paris', 'Lyon', 'Nice', 'Lille'],
          correctAnswerIndex: 0,
        ),
      ]);

      expect(await service.getCategories(), isNotNull);
      expect(await service.getQuestions('geo'), isNotNull);

      await service.invalidateAll();

      expect(await service.getCategories(), isNull);
      expect(await service.getQuestions('geo'), isNull);
      expect(await service.getQuestionsStale('geo'), isNull);
    });
  });
}