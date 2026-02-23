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

  Question({
    required this.id,
    required this.category,
    required this.question,
    required this.answers,
    required this.correctAnswerIndex,
    this.difficulty = Difficulty.medium,
    this.explanation,
  });
}
