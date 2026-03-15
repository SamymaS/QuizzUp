import 'package:flutter_test/flutter_test.dart';
import 'package:quizzup/models/question.dart';

/// ─────────────────────────────────────────────────────────────
/// Tests unitaires du modèle Question et de l'enum Difficulty.
///
/// Objectif :
/// Vérifier que la logique liée aux questions du quiz fonctionne
/// correctement.
///
/// Les tests couvrent :
/// - les propriétés de l'enum Difficulty
/// - la conversion des données via Question.fromMap()
/// - la gestion des cas particuliers (valeurs inconnues, alias)
///
/// Importance :
/// Ce modèle est central dans le fonctionnement du moteur du quiz.
/// Une erreur ici impacterait directement la durée des questions,
/// l'affichage des catégories ou la validation des réponses.
void main() {
  /// ─────────────────────────────────────────────────────────────
  /// Tests de l'enum Difficulty
  ///
  /// L'enum Difficulty définit les niveaux de difficulté des
  /// questions ainsi que certaines propriétés associées :
  /// - la limite de temps pour répondre
  /// - le label affiché dans l'interface.
  group('Difficulty', () {
    /// Vérifie que chaque niveau de difficulté possède
    /// la bonne limite de temps pour répondre à une question.
    ///
    /// Easy → 15 secondes
    /// Medium → 10 secondes
    /// Hard → 8 secondes
    ///
    /// Ces valeurs sont utilisées par le moteur du quiz
    /// pour limiter le temps de réponse du joueur.
    test('retourne la bonne limite de temps', () {
      expect(Difficulty.easy.timeLimit, 15);
      expect(Difficulty.medium.timeLimit, 10);
      expect(Difficulty.hard.timeLimit, 8);
    });

    /// Vérifie que chaque niveau de difficulté retourne
    /// le bon label textuel utilisé dans l'interface.
    ///
    /// Ces labels sont affichés à l'utilisateur pour indiquer
    /// le niveau de difficulté de la question.
    test('retourne le bon label', () {
      expect(Difficulty.easy.label, 'Facile');
      expect(Difficulty.medium.label, 'Moyen');
      expect(Difficulty.hard.label, 'Difficile');
    });
  });

  /// ─────────────────────────────────────────────────────────────
  /// Tests du modèle Question
  ///
  /// Ces tests vérifient que la classe Question se construit
  /// correctement à partir des données provenant d'une API
  /// ou d'une base de données.
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

    /// Vérifie que la méthode fromMap() construit correctement
    /// un objet Question à partir d'une Map.
    ///
    /// Ce test valide :
    /// - l'id de la question
    /// - la catégorie
    /// - le texte de la question
    /// - la liste des réponses
    /// - l'index de la bonne réponse
    /// - la difficulté
    /// - l'explication associée.
    ///
    /// Ce test simule la réception de données depuis une API.
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

    /// Vérifie que la propriété categoryId est bien
    /// un alias de la propriété category.
    ///
    /// Cela garantit la compatibilité avec différents formats
    /// de données provenant d'API ou de bases de données.
    test('categoryId est un alias de category', () {
      final q = Question.fromMap(map);
      expect(q.categoryId, q.category);
    });

    /// Vérifie que la limite de temps est correctement
    /// définie lorsque la difficulté est "easy".
    ///
    /// Easy doit correspondre à une limite de 15 secondes.
    test('timeLimit easy = 15s', () {
      final q = Question.fromMap(map);
      expect(q.timeLimit, 15);
    });

    /// Vérifie que la limite de temps est correctement
    /// définie lorsque la difficulté est "medium".
    ///
    /// Medium doit correspondre à une limite de 10 secondes.
    test('timeLimit medium = 10s', () {
      final q = Question.fromMap({...map, 'difficulty': 'medium'});
      expect(q.timeLimit, 10);
    });

    /// Vérifie que la limite de temps est correctement
    /// définie lorsque la difficulté est "hard".
    ///
    /// Hard doit correspondre à une limite de 8 secondes.
    test('timeLimit hard = 8s', () {
      final q = Question.fromMap({...map, 'difficulty': 'hard'});
      expect(q.timeLimit, 8);
    });

    /// Vérifie le comportement de sécurité lorsque la difficulté
    /// fournie dans les données est inconnue.
    ///
    /// Dans ce cas, la difficulté doit automatiquement être
    /// définie à "medium".
    ///
    /// Cela évite les erreurs si l'API envoie une valeur inattendue.
    test('difficulty inconnue → medium par défaut', () {
      final q = Question.fromMap({...map, 'difficulty': 'unknownlevel'});
      expect(q.difficulty, Difficulty.medium);
    });

    /// Vérifie que la méthode fromMap() accepte également
    /// le champ "category" au lieu de "category_id".
    ///
    /// Cela permet de gérer différents formats de données
    /// selon la source (API, base locale, etc.).
    test('fromMap avec category au lieu de category_id', () {
      final altMap = {...map};
      altMap.remove('category_id');
      altMap['category'] = '5';

      final q = Question.fromMap(altMap);

      expect(q.category, '5');
    });
  });
}