import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzup/models/question.dart';
import 'package:quizzup/models/user_stats.dart';
import 'package:quizzup/models/game_history.dart';
import 'package:quizzup/models/badge.dart';
import 'package:quizzup/models/category.dart';

void main() {
  // ── Question ──────────────────────────────────────────────────────────────

  group('Question', () {
    final map = {
      'id': '42',
      'category_id': '3',
      'question': 'Quelle est la capitale de la France ?',
      'answers': ['Berlin', 'Paris', 'Madrid', 'Rome'],
      'correct_answer_index': 1,
      'difficulty': 'easy',
      'explanation': 'Paris est la capitale de la France depuis des siècles.',
    };

    test('fromMap construit correctement', () {
      final q = Question.fromMap(map);
      expect(q.id, '42');
      expect(q.category, '3');
      expect(q.question, 'Quelle est la capitale de la France ?');
      expect(q.answers.length, 4);
      expect(q.correctAnswerIndex, 1);
      expect(q.difficulty, Difficulty.easy);
      expect(q.explanation, isNotNull);
    });

    test('categoryId est un alias de category', () {
      final q = Question.fromMap(map);
      expect(q.categoryId, q.category);
    });

    test('timeLimit easy = 15s', () {
      final q = Question.fromMap(map);
      expect(q.timeLimit, 15);
    });

    test('timeLimit medium = 10s', () {
      final q = Question.fromMap({...map, 'difficulty': 'medium'});
      expect(q.timeLimit, 10);
    });

    test('timeLimit hard = 8s', () {
      final q = Question.fromMap({...map, 'difficulty': 'hard'});
      expect(q.timeLimit, 8);
    });

    test('difficulty inconnue → medium par défaut', () {
      final q = Question.fromMap({...map, 'difficulty': 'unknownlevel'});
      expect(q.difficulty, Difficulty.medium);
    });

    test('fromMap avec category (pas category_id)', () {
      final altMap = {...map};
      altMap.remove('category_id');
      altMap['category'] = '5';
      final q = Question.fromMap(altMap);
      expect(q.category, '5');
    });
  });

  // ── UserStats ─────────────────────────────────────────────────────────────

  group('UserStats', () {
    test('constructeur par défaut à zéro', () {
      final s = UserStats();
      expect(s.victories, 0);
      expect(s.totalGames, 0);
      expect(s.winRate, 0.0);
    });

    test('copyWith modifie uniquement les champs spécifiés', () {
      final s = UserStats(victories: 3, totalGames: 5, winRate: 60.0);
      final updated = s.copyWith(victories: 4, totalGames: 6);
      expect(updated.victories, 4);
      expect(updated.totalGames, 6);
      expect(updated.winRate, 60.0);
    });

    test('toJson / fromJson aller-retour', () {
      final s = UserStats(
        victories: 7,
        totalGames: 10,
        totalWins: 7,
        totalLosses: 3,
        winRate: 70.0,
      );
      final json = s.toJson();
      final restored = UserStats.fromJson(json);
      expect(restored.victories, s.victories);
      expect(restored.totalGames, s.totalGames);
      expect(restored.winRate, s.winRate);
    });

    test('fromJson avec valeurs null → défauts à 0', () {
      final s = UserStats.fromJson({});
      expect(s.victories, 0);
      expect(s.totalGames, 0);
      expect(s.winRate, 0.0);
    });
  });

  // ── GameHistory ───────────────────────────────────────────────────────────

  group('GameHistory', () {
    final now = DateTime(2026, 3, 14, 10, 0);
    final history = GameHistory(
      id: 'h1',
      opponentName: 'Alice',
      category: 'Sport',
      playedAt: now,
      isWin: true,
      myScore: 8,
      opponentScore: 5,
      result: 'Victoire',
    );

    test('toJson contient tous les champs', () {
      final json = history.toJson();
      expect(json['id'], 'h1');
      expect(json['opponentName'], 'Alice');
      expect(json['isWin'], true);
      expect(json['myScore'], 8);
    });

    test('fromJson reconstruit correctement', () {
      final json = history.toJson();
      final restored = GameHistory.fromJson(json);
      expect(restored.id, history.id);
      expect(restored.opponentName, history.opponentName);
      expect(restored.playedAt, history.playedAt);
      expect(restored.isWin, history.isWin);
    });
  });

  // ── UserBadge ─────────────────────────────────────────────────────────────

  group('UserBadge', () {
    final badge = UserBadge(
      id: 'badge_1v',
      name: 'Premier Duel',
      description: 'Gagnez votre premier duel',
      icon: '🏆',
    );

    test('isUnlocked à false par défaut', () {
      expect(badge.isUnlocked, false);
      expect(badge.unlockedAt, isNull);
    });

    test('copyWith débloque le badge', () {
      final unlocked = badge.copyWith(
        isUnlocked: true,
        unlockedAt: DateTime(2026, 3, 14),
      );
      expect(unlocked.isUnlocked, true);
      expect(unlocked.unlockedAt, isNotNull);
      expect(unlocked.name, badge.name);
    });

    test('toJson / fromJson aller-retour', () {
      final json = badge.toJson();
      final restored = UserBadge.fromJson(json);
      expect(restored.id, badge.id);
      expect(restored.isUnlocked, false);
      expect(restored.unlockedAt, isNull);
    });

    test('fromJson avec badge débloqué', () {
      final unlocked = badge.copyWith(
        isUnlocked: true,
        unlockedAt: DateTime(2026, 3, 14),
      );
      final restored = UserBadge.fromJson(unlocked.toJson());
      expect(restored.isUnlocked, true);
      expect(restored.unlockedAt, isNotNull);
    });
  });

  // ── Category ──────────────────────────────────────────────────────────────

  group('Category', () {
    test('fromMap construit correctement', () {
      final map = {
        'id': '1',
        'name': 'Culture Générale',
        'icon': '🧠',
        'color_hex': 'DC2626',
        'question_count': 50,
        'sort_order': 1,
      };
      final cat = Category.fromMap(map);
      expect(cat.id, '1');
      expect(cat.name, 'Culture Générale');
      expect(cat.icon, '🧠');
      expect(cat.questionCount, 50);
      expect(cat.color, isA<Color>());
    });

    test('fromMap hex invalide → couleur par défaut', () {
      final map = {
        'id': '2',
        'name': 'Test',
        'icon': '❓',
        'color_hex': 'ZZZZZZ',
        'question_count': 0,
      };
      final cat = Category.fromMap(map);
      expect(cat.color, const Color(0xFFDC2626));
    });

    test('fromMap sans color_hex → couleur par défaut', () {
      final map = {
        'id': '3',
        'name': 'Test',
        'icon': '❓',
      };
      final cat = Category.fromMap(map);
      expect(cat.color, const Color(0xFFDC2626));
    });
  });
}
