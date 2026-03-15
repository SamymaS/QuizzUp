import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizzup/models/user_stats.dart';
import 'package:quizzup/models/game_history.dart';
import 'package:quizzup/models/badge.dart';
import 'package:quizzup/models/category.dart';

/// ─────────────────────────────────────────────────────────────
/// Tests unitaires des modèles principaux de l'application.
///
/// Modèles testés :
/// - UserStats
/// - GameHistory
/// - UserBadge
/// - Category
///
/// Objectif :
/// Vérifier que les objets métiers du jeu
/// fonctionnent correctement indépendamment de l'interface.
///
/// Ce qui est testé :
/// - la construction des objets
/// - la conversion JSON
/// - les valeurs par défaut
/// - la gestion des erreurs de données
///
/// Importance :
/// Ces modèles sont utilisés dans toute l'application.
/// Leur fiabilité garantit la cohérence des données du jeu.
void main() {
  /// ─────────────────────────────────────────────────────────────
  /// Tests du modèle UserStats
  ///
  /// Ce modèle stocke les statistiques principales du joueur :
  /// victoires, parties jouées, taux de victoire, etc.
  group('UserStats', () {
    /// Vérifie que le constructeur par défaut initialise
    /// correctement les statistiques à zéro.
    test('constructeur par défaut à zéro', () {
      final s = UserStats();
      expect(s.victories, 0);
      expect(s.totalGames, 0);
      expect(s.winRate, 0.0);
    });

    /// Vérifie que copyWith() ne modifie que les champs fournis
    /// et conserve les autres valeurs inchangées.
    test('copyWith modifie uniquement les champs spécifiés', () {
      final s = UserStats(victories: 3, totalGames: 5, winRate: 60.0);
      final updated = s.copyWith(victories: 4, totalGames: 6);

      expect(updated.victories, 4);
      expect(updated.totalGames, 6);
      expect(updated.winRate, 60.0);
    });

    /// Vérifie qu'un objet UserStats peut être sérialisé
    /// en JSON puis reconstruit sans perte d'information.
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

    /// Vérifie que fromJson() retourne des valeurs par défaut
    /// lorsque les champs attendus sont absents.
    test('fromJson avec valeurs null → défauts à 0', () {
      final s = UserStats.fromJson({});

      expect(s.victories, 0);
      expect(s.totalGames, 0);
      expect(s.winRate, 0.0);
    });
  });

  /// ─────────────────────────────────────────────────────────────
  /// Tests du modèle GameHistory
  ///
  /// Ce modèle représente une partie jouée dans l'historique.
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

    /// Vérifie que toJson() contient bien tous les champs utiles
    /// nécessaires à la persistance de l'historique.
    test('toJson contient tous les champs', () {
      final json = history.toJson();

      expect(json['id'], 'h1');
      expect(json['opponentName'], 'Alice');
      expect(json['isWin'], true);
      expect(json['myScore'], 8);
    });

    /// Vérifie qu'un historique sérialisé en JSON
    /// peut être reconstruit correctement via fromJson().
    test('fromJson reconstruit correctement', () {
      final json = history.toJson();
      final restored = GameHistory.fromJson(json);

      expect(restored.id, history.id);
      expect(restored.opponentName, history.opponentName);
      expect(restored.playedAt, history.playedAt);
      expect(restored.isWin, history.isWin);
    });
  });

  /// ─────────────────────────────────────────────────────────────
  /// Tests du modèle UserBadge
  ///
  /// Ce modèle gère les badges de progression du joueur.
  group('UserBadge', () {
    final badge = UserBadge(
      id: 'badge_1v',
      name: 'Premier Duel',
      description: 'Gagnez votre premier duel',
      icon: '🏆',
    );

    /// Vérifie qu'un badge est verrouillé par défaut
    /// lorsqu'il vient d'être créé.
    test('isUnlocked à false par défaut', () {
      expect(badge.isUnlocked, false);
      expect(badge.unlockedAt, isNull);
    });

    /// Vérifie que copyWith() permet de marquer un badge
    /// comme débloqué tout en conservant ses autres informations.
    test('copyWith débloque le badge', () {
      final unlocked = badge.copyWith(
        isUnlocked: true,
        unlockedAt: DateTime(2026, 3, 14),
      );

      expect(unlocked.isUnlocked, true);
      expect(unlocked.unlockedAt, isNotNull);
      expect(unlocked.name, badge.name);
    });

    /// Vérifie la sérialisation et désérialisation JSON
    /// d'un badge encore verrouillé.
    test('toJson / fromJson aller-retour', () {
      final json = badge.toJson();
      final restored = UserBadge.fromJson(json);

      expect(restored.id, badge.id);
      expect(restored.isUnlocked, false);
      expect(restored.unlockedAt, isNull);
    });

    /// Vérifie qu'un badge débloqué conserve bien son état
    /// après un aller-retour JSON.
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

  /// ─────────────────────────────────────────────────────────────
  /// Tests du modèle Category
  ///
  /// Ce modèle représente une catégorie de quiz affichée
  /// dans l'application.
  group('Category', () {
    /// Vérifie que fromMap() construit correctement
    /// une catégorie à partir d'une Map.
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

    /// Vérifie qu'une couleur hexadécimale invalide
    /// déclenche l'utilisation de la couleur par défaut.
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

    /// Vérifie que l'absence de color_hex
    /// utilise également la couleur par défaut.
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