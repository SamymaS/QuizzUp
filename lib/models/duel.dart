class Duel {
  final String id;
  final String opponentName;
  final String category;
  final DateTime? createdAt;
  final bool isCompleted;
  final String? winnerId;

  const Duel({
    required this.id,
    required this.opponentName,
    required this.category,
    this.createdAt,
    this.isCompleted = false,
    this.winnerId,
  });
}
