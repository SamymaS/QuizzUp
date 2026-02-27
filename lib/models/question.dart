enum Difficulty {
  easy,
  medium,
  hard;

  int get timeLimit {
    switch (this) {
      case Difficulty.easy:
        return 15;
      case Difficulty.medium:
        return 10;
      case Difficulty.hard:
        return 8;
    }
  }

  String get label {
    switch (this) {
      case Difficulty.easy:
        return 'Facile';
      case Difficulty.medium:
        return 'Moyen';
      case Difficulty.hard:
        return 'Difficile';
    }
  }
}

class Question {
  final String id;
  final String category;
  final String question;
  final List<String> answers;
  final int correctAnswerIndex;
  final Difficulty difficulty;
  final String? explanation;

  int get timeLimit => difficulty.timeLimit;

  /// Alias used by cache / Supabase mapping (maps to [category]).
  String get categoryId => category;

  Question({
    required this.id,
    required this.category,
    required this.question,
    required this.answers,
    required this.correctAnswerIndex,
    this.difficulty = Difficulty.medium,
    this.explanation,
  });

  factory Question.fromMap(Map<String, dynamic> map) {
    final rawAnswers = map['answers'];
    final List<String> answers;
    if (rawAnswers is List) {
      answers = rawAnswers.map((e) => e.toString()).toList();
    } else {
      answers = List<String>.from(rawAnswers as Iterable);
    }
    return Question(
      id: map['id']?.toString() ?? '',
      category: map['category_id']?.toString() ?? map['category']?.toString() ?? '',
      question: map['question'] as String,
      answers: answers,
      correctAnswerIndex: map['correct_answer_index'] as int,
      difficulty: Difficulty.values.firstWhere(
        (d) => d.name == (map['difficulty'] ?? 'medium'),
        orElse: () => Difficulty.medium,
      ),
      explanation: map['explanation'] as String?,
    );
  }
}
