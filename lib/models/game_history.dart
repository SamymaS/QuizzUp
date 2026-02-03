class GameHistory {
  final String id;
  final String opponentName;
  final String category;
  final DateTime playedAt;
  final bool isWin;
  final int myScore;
  final int opponentScore;
  final String? result;

  GameHistory({
    required this.id,
    required this.opponentName,
    required this.category,
    required this.playedAt,
    required this.isWin,
    required this.myScore,
    required this.opponentScore,
    this.result,
  });
}
