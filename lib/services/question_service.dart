import 'dart:math';
import '../models/question.dart';
import '../data/questions_data.dart';

class QuestionService {
  static final Random _random = Random();

  /// Récupère 10 questions aléatoires pour une catégorie donnée
  static List<Question> getRandomQuestions(String categoryId, {int count = 10}) {
    final allQuestions = QuestionsData.getQuestionsByCategory(categoryId);
    
    if (allQuestions.length < count) {
      // Si on a moins de questions que demandé, on retourne toutes les questions
      return List.from(allQuestions);
    }

    // Mélange et sélectionne 'count' questions aléatoires
    final shuffled = List<Question>.from(allQuestions)..shuffle(_random);
    return shuffled.take(count).toList();
  }

  /// Récupère toutes les questions d'une catégorie
  static List<Question> getAllQuestionsByCategory(String categoryId) {
    return QuestionsData.getQuestionsByCategory(categoryId);
  }

  /// Vérifie si une catégorie a suffisamment de questions
  static bool hasEnoughQuestions(String categoryId, {int minimum = 25}) {
    return getAllQuestionsByCategory(categoryId).length >= minimum;
  }
}
