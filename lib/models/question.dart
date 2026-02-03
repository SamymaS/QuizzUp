class Question {
  final String id;
  final String category;
  final String question;
  final List<String> answers;
  final int correctAnswerIndex;
  final int timeLimit; // en secondes

  Question({
    required this.id,
    required this.category,
    required this.question,
    required this.answers,
    required this.correctAnswerIndex,
    this.timeLimit = 10,
  });
}
